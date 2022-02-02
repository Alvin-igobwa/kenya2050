#!/bin/bash

set -euo pipefail

rm -rf work/model
mkdir -p work/model
base_dir = ENV["BASEDIR"]

command = ExcelToC.new

command.excel_file = File.join(base_dir, "input.xlsx")

command.output_name = "excelspreadsheet"
command.output_directory = "model"

command.named_references_that_can_be_set_at_runtime = ["input.lever.ambition", "input.lever.start", "input.lever.end"]

yml_path = File.join(base_dir, "work", command.output_directory, "outputs.yml")
command.named_references_to_keep = YAML.load(File.read(yml_path))

command.go!