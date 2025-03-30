#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import numpy as np
import random
from random import seed, sample
from statistics import mean, StatisticsError
import argparse
import sys
import os
from tqdm import tqdm  # For progress bar

# Function to ensure the output directory exists
def main(input_csv):
    print()
    print("======================================")
    print("Step 1: Loading the dataset...")
    df = pd.read_csv(input_csv, header=None)
    print()
    print(f"Dataset loaded. Shape: {df.shape}")

    print()
    print("======================================")
    print("Step 2: Converting the dataset into a list and checking for missing values")
    dfint = df.values.tolist()
    df1 = [
        [x for x in y if isinstance(x, (int, float)) and not np.isnan(x)] 
        for y in dfint
    ]
    print()
    print("Conversion complete")

    print()
    print("======================================")
    print("Step 3: Generating random samples")

    # Function to generate random combinations without replacement
    # This function generates random combinations of a specified size from the data.
    # It returns a list of tuples, each containing the selected items.
    
    def random_combinations(data, n):
        return [tuple([item]) for item in random.sample(data, min(n, len(data)))] if len(data) >= n else []

    # Function to take samples from the data
    # This function takes a specified number of branches (1, 2, 3, 4, 5, 10, 15).
    def take_samples(data_list, num_samples, sample_sizes):
        random.seed(10)
        results = {size: [] for size in sample_sizes}
        for size in tqdm(sample_sizes, desc="Sampling progress"):
            for _ in range(num_samples):
                for data in data_list:
                    sample = random_combinations(data, size)
                    results[size].append(sample)
        return results

    sample_sizes = [1, 2, 3, 4, 5, 10, 15]
    all_samples = take_samples(df1, 100, sample_sizes)

    print()
    print("======================================")
    print("Step 4: Calculating averages")


    # Function to calculate averages of the branches (ABEL)
    def calculate_averages(lists_dict):
        averages_dict = {}
        for key, list_of_lists in tqdm(lists_dict.items(), desc="Averaging progress"):
            list_averages = []
            for single_list in list_of_lists:
                try:
                    flat_list = [item for sublist in single_list for item in sublist]
                    if flat_list:
                        list_averages.append([mean(flat_list)])
                    else:
                        list_averages.append([None])
                except StatisticsError:
                    list_averages.append([None])
            averages_dict[key] = list_averages
        return averages_dict

    all_averages = calculate_averages(all_samples)

    print()
    print("======================================")
    print("Step 5: Converting averages to arrays")
    
    # This function converts the averages dictionary into a numpy array format.
    def convert_to_arrays(all_averages):
        return {k: np.array(v, dtype=object) for k, v in all_averages.items()}

    all_arrays = convert_to_arrays(all_averages)

    print()
    print("======================================")
    print("Step 6: Converting arrays to DataFrames")

    # This function converts the numpy arrays into pandas DataFrames.
    def convert_arrays_to_dataframes(all_arrays):
        return {k: pd.DataFrame([np.ravel(arr) for arr in v]) for k, v in all_arrays.items()}

    all_dataframes = convert_arrays_to_dataframes(all_arrays)


    print()
    print("======================================")
    print("Step 7: Reshaping DataFrames")

    # This function reshapes the DataFrames to have a specified number of rows.
    # It calculates the new number of columns based on the total number of elements.
    def reshape_dataframes(all_dataframes, desired_rows):
        reshaped = {}
        for k, df in tqdm(all_dataframes.items(), desc="Reshaping progress"):
            total_elements = df.shape[0] * df.shape[1]
            new_cols = total_elements // desired_rows
            if total_elements % desired_rows == 0:
                reshaped[k] = pd.DataFrame(df.to_numpy().reshape(desired_rows, new_cols))
            else:
                print(f"Cannot perfectly reshape branch {k} data of size {df.shape} into {desired_rows} rows.")
        return reshaped

    reshaped_dataframes = reshape_dataframes(all_dataframes, 100)

    print()
    print("======================================")
    print("Step 8: Transposing DataFrames")

    # This function transposes the DataFrames to switch rows and columns.
    # This is useful for certain types of data analysis and visualization.
    def transpose_dataframes(all_dataframes):
        transposed = {}
        for k, df in tqdm(all_dataframes.items(), desc="Transposing progress"):
            transposed[k] = df.T
        return transposed

    transposed_dataframes = transpose_dataframes(reshaped_dataframes)

    print()
    print("======================================")
    print("Step 9: Applying threshold")

    # This function applies a threshold (neurons > 14.33, glia < 14.33) to the DataFrames.
    # Values below the threshold are set to 0, and values above or equal to the threshold are set to 1.
    def apply_threshold(all_dataframes, threshold):
        for df in tqdm(all_dataframes.values(), desc="Thresholding progress"):
            df[df < threshold] = 0
            df[df >= threshold] = 1

    apply_threshold(transposed_dataframes, 14.33)

    print()
    print("======================================")
    print("Step 10: Saving DataFrames to CSV files")

    # This function saves each DataFrame to a CSV file in the specified output directory.
    def save_dataframes_to_csv(all_dataframes):
        # Ensure the output directory exists
        output_dir = "glia"
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            print(f"Created directory: {output_dir}")

        # Save each DataFrame to the output directory
        for branch, df in tqdm(all_dataframes.items(), desc="Saving progress"):
            output_filename = os.path.join(output_dir, f"Glia_Branch-{branch}.csv")
            df.to_csv(output_filename, index=False, header=False)

    save_dataframes_to_csv(transposed_dataframes)
    print()
    print("All steps completed successfully!")
    print()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process and save DataFrames from a CSV file.")
    parser.add_argument("input_csv", help="Path to the input CSV file.")
    args = parser.parse_args()

    try:
        main(args.input_csv)
    except Exception as e:
        print(f"An error occurred: {e}", file=sys.stderr)
        sys.exit(1)

