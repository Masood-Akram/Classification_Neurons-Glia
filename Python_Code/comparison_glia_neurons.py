#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import argparse
import json
import sys
import os

# Function to ensure the output directory exists
# def ensure_output_directory(output_file):
def ensure_output_directory(output_file):
    """
    Ensure the directory for the output file exists. If not, create it.
    """
    output_dir = os.path.dirname(output_file)
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created directory: {output_dir}")

# Function to process a single branch
def process_branch(glia_file, neuron_file):
    """
    Process a single branch by concatenating glial and neuronal data,
    and calculating the mean, 95th percentile, and 5th percentile.
    """
    # Load the glial and neuronal data
    Glia = pd.read_csv(glia_file, header=None)
    Neuron = pd.read_csv(neuron_file, header=None)

    # Step 1: Concatenate both files into one DataFrame
    Branch = pd.concat([Glia, Neuron])

    # Step 2: Take the average of 100 samples (column-wise) of the whole dataset
    Mean1 = Branch.mean(axis=0)

    # Step 3: Calculate the overall mean
    Mean = Mean1.mean(axis=0)

    # Step 4: Calculate the 95th percentile (Max)
    Max = Mean1.quantile(0.95)

    # Step 5: Calculate the 5th percentile (Min)
    Min = Mean1.quantile(0.05)

    return Mean, Max, Min

# Function to process all branches specified in the config file
def process_all_branches(config_file):
    """
    Process all branches specified in the config file and save the results to a CSV file.
    """
    # Load the configuration file
    with open(config_file, "r") as f:
        config = json.load(f)

    glia_files = config["glia_files"]
    neuron_files = config["neuron_files"]
    output_file = config["output_file"]

    # Ensure the output directory exists
    ensure_output_directory(output_file)

    # Validate that the number of glial and neuronal files match
    if len(glia_files) != len(neuron_files):
        print("Error: The number of glial and neuronal files does not match.", file=sys.stderr)
        sys.exit(1)

    # Prepare a list to store the results
    results = []

    # Process each branch
    for glia_file, neuron_file in zip(glia_files, neuron_files):
        try:
            print(f"Processing: {glia_file} and {neuron_file}")
            Mean, Max, Min = process_branch(glia_file, neuron_file)
            branch_name = glia_file.split('-')[1].split('.')[0]  # Extract branch number
            results.append({"Branch": branch_name, "Mean": Mean, "Max": Max, "Min": Min})
        except Exception as e:
            print(f"Error processing {glia_file} and {neuron_file}: {e}", file=sys.stderr)

    # Convert results to a DataFrame and save to CSV
    results_df = pd.DataFrame(results)
    results_df.to_csv(output_file, index=False)
    print(f"Results saved to {output_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process glial and neuronal files for all branches.")
    parser.add_argument("--config", required=True, help="Path to the JSON configuration file.")
    args = parser.parse_args()

    try:
        process_all_branches(args.config)
    except Exception as e:
        print(f"An error occurred: {e}", file=sys.stderr)
        sys.exit(1)