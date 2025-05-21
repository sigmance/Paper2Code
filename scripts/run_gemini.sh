# export GOOGLE_API_KEY=""

GEMINI_VERSION="gemini-2.5-pro-preview-05-06"

PAPER_NAME="Towards_an_AI_co-scientist_${GEMINI_VERSION}"
PDF_PATH="/Users/taddeusbuica/Desktop/experiments/Paper2Code/Towards_an_AI_co-scientist2502.18864v1.pdf" # .pdf
PDF_JSON_PATH="/Users/taddeusbuica/Desktop/experiments/Paper2Code/data/paper_json/Towards_an_AI_co-scientist2502.18864v1.json" # .json
PDF_JSON_CLEANED_PATH="../examples/Towards_an_AI_co-scientist2502.18864v1.json" # _cleaned.json
OUTPUT_DIR="../outputs/Towards_an_AI_co-scientist_${GEMINI_VERSION}"
OUTPUT_REPO_DIR="../outputs/Towards_an_AI_co-scientist_repo_${GEMINI_VERSION}"

mkdir -p $OUTPUT_DIR
mkdir -p $OUTPUT_REPO_DIR

echo $PAPER_NAME

echo "------- Preprocess -------"
python ../codes/0_pdf_process.py \
    --input_json_path ${PDF_JSON_PATH} \
    --output_json_path ${PDF_JSON_CLEANED_PATH}


echo "------- PaperCoder -------"
python ../codes/1_planning_gemini.py \
    --paper_name $PAPER_NAME \
    --gemini_version ${GEMINI_VERSION} \
    --pdf_json_path ${PDF_JSON_CLEANED_PATH} \
    --output_dir ${OUTPUT_DIR}

python ../codes/1.1_extract_config.py \
    --paper_name $PAPER_NAME \
    --output_dir ${OUTPUT_DIR}

cp -rp ${OUTPUT_DIR}/planning_config.yaml ${OUTPUT_REPO_DIR}/config.yaml

python ../codes/2_analyzing_gemini.py \
    --paper_name $PAPER_NAME \
    --gemini_version ${GEMINI_VERSION} \
    --pdf_json_path ${PDF_JSON_CLEANED_PATH} \
    --output_dir ${OUTPUT_DIR}

python ../codes/3_coding_gemini.py \
    --paper_name $PAPER_NAME \
    --gemini_version ${GEMINI_VERSION} \
    --pdf_json_path ${PDF_JSON_CLEANED_PATH} \
    --output_dir ${OUTPUT_DIR} \
    --output_repo_dir ${OUTPUT_REPO_DIR}
