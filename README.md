<div align="center">

# VLM-Pruner: Buffering for Spatial Sparsity in an Efficient VLM Centrifugal Token Pruning Paradigm

**Zhenkai Wu**<sup>1,2</sup><sup>†</sup> &nbsp;
**Xiaowen Ma**<sup>2</sup><sup>†</sup> &nbsp;
**Zhenliang Ni**<sup>2</sup>  

**Dengming Zhang**<sup>1,2</sup> &nbsp;
**Han Shu**<sup>2</sup> &nbsp;
**Xin Jiang**<sup>2</sup> &nbsp;
**Xinghao Chen**<sup>2</sup><sup>✉</sup>

<sup>1</sup> Zhejiang University  <sup>2</sup> Huawei Noah’s Ark Lab  

<sup>†</sup> Equal contribution.  
<sup>✉</sup> Corresponding author: xinghao.chen@huawei.com.

<sup>📕</sup> Arxiv version: [here](https://arxiv.org/abs/2512.02700).
</div>

## 🔥 News
- `2025/12/31`: The instructions for the usage of this repository with **LLaVA-1.5-7b/13b** and **Qwen2-VL-7B** have been updated.
- `2025/12/15`: The official implementation of VLM-Pruner is available!
- `2025/12/02`: VLM-Pruner has been submitted to Arxiv, see [here](https://arxiv.org/abs/2512.02700). 

## 🔧 Instructions
### LLaVA-1.5-7b/13b
1. Environment Setup
```shell
conda create -n VLMPruner python=3.10 -y
conda activate VLMPruner
pip install -e .
pip install flash-attn --no-build-isolation --no-cache-dir
pip install accelerate deepspeed --upgrade
pip install protobuf
pip install transformers_stream_generator
pip install openpyxl
```
2. Download Multimodal Benchmarks
   
   (1) Please follow the detailed instruction in [LLaVA-Evaluation](https://github.com/haotian-liu/LLaVA/blob/main/docs/Evaluation.md):

   Please download [eval.zip](https://drive.google.com/file/d/1atZSBBrAX54yYpxtVVW33zFvcnaHeFPy/view?usp=sharing) and extract it to `./playground/data/eval`.

   Please download benchmarks including **GQA**, **ScienceQA**, **TextVQA**, **POPE**, **MME**, and **MMBench**.

   (2) Please refer to [OCRBench](https://github.com/Yuliang-Liu/MultimodalOCR/tree/main/OCRBench) to download **OCRBench**:

   Download [OCRBench Images](https://drive.google.com/file/d/1a3VRJx3V3SdOmPr7499Ky0Ug8AwqGUHO/view?usp=drive_link) and [OCRBench json](https://github.com/Yuliang-Liu/MultimodalOCR/blob/main/OCRBench/OCRBench/OCRBench.json).

   Extract them to `./playground/data/eval/OCRBench/OCRBench_Images` and `./playground/data/eval/OCRBench/OCRBench/OCRBench.json`, respectively.

   (3) Please follow the detailed instrunction in [additional benchmarks](https://internvl.readthedocs.io/en/latest/get_started/eval_data_preparation.html#) to download additional benchmarks including **SEED-Image** and **OKVQA**.

3. Download Models' Pretrained Weights:
   
   Download [clip-vit-large-patch14-336](https://huggingface.co/openai/clip-vit-large-patch14-336), [llava-v1.5-7b](https://huggingface.co/liuhaotian/llava-v1.5-7b), and [llava-v1.5-13b](https://huggingface.co/liuhaotian/llava-v1.5-13b) and put them to `/cache/huggingface/`.

4. Usage
```shell
bash scripts/v1_5/eval/[Benchmark].sh [Reduction_Ratio] [Similarity_Threshold] [Token_Batch]
    └── CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/mme.sh 0.889 0.8 16
    └── CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/pope.sh 0.778 0.8 16
    └── CUDA_VISIBLE_DEVICES=0,1 bash scripts/v1_5/eval/okvqa.sh 0.889 0.8 16
    └── CUDA_VISIBLE_DEVICES=0,1 bash scripts/v1_5/eval/seed.sh 0.667 0.8 16
```

### Qwen2-VL-7B
1. Environment Setup
```shell
conda create -n VLMPruner_Qwen2VL python=3.10 -y
conda activate VLMPruner_Qwen2VL
cd Qwen2-VL/transformers && pip install -e .
conda install av -c conda-forge
conda install -c conda-forge pyarrow
pip install accelerate qwen-vl-utils[decord]
pip install flash-attn --no-build-isolation
conda install -c conda-forge wandb
pip install tiktoken --only-binary :all:
cd ../../lmms-eval && pip install -e .
```

2. Download Multimodal Benchmarks

   Please download [GQA](https://huggingface.co/datasets/lmms-lab/GQA), [MMBench](https://huggingface.co/datasets/lmms-lab/MMBench), [MME](https://huggingface.co/datasets/lmms-lab/MME), [OCRBench](https://huggingface.co/datasets/echo840/OCRBench), [POPE](https://huggingface.co/datasets/lmms-lab/POPE), [ScienceQA]([https://huggingface.co/datasets/lmms-lab/ScienceQA-IMG](https://huggingface.co/datasets/lmms-lab/ScienceQA)), [SEED-Bench](https://huggingface.co/datasets/lmms-lab/SEED-Bench), [textvqa](https://huggingface.co/datasets/lmms-lab/textvqa), and [OK-VQA](https://huggingface.co/datasets/lmms-lab/OK-VQA).

   Please put them into `Qwen2-VL/lmms-lab/`.

3. Download Models' Pretrained Weights:
   
   Download [Qwen2-VL-7B](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct) and put them to `/cache/huggingface/`.

4. Usage
   
   If you want to use multiple GPUs to run in parallel, please modify both export `CUDA_VISIBLE_DEVICES=0` and `--num_processes=1` in the `[benchmark].sh` file. For example, they can be changed to `CUDA_VISIBLE_DEVICES=0,1` and `--num_processes=2`.
```shell
cd Qwen2-VL
bash eval_scripts/[Benchmark].sh [Reduction_Ratio] [Similarity_Threshold] [Token_Batch]
    └── bash eval_scripts/lmms_eval_mme.sh 0.889 0.8 16
    └── bash eval_scripts/lmms_eval_ocrbench.sh 0.778 0.8 16
    └── bash eval_scripts/lmms_eval_pope.sh 0.667 0.8 16
```

## 💻Core Codes
```text
./VLMPruner/llava/model/language_model/modeling_llama_self.py
    └── class VLMPruner(LlamaModel)

./VLMPruner/Qwen2-VL/Qwen2VL_VLMPruner/modeling_qwen2_vl_self.py
    └── class VLMPruner(Qwen2VLModel)
```

## 👀 Overview
![intro1](./fig/fig_intro.png)
**Figure 1. Comparisons between baselines and VLM-Pruner. Left**: Visual question answering examples with correct (green) and incorrect (red) responses; numbers (from 1 to 64) denote token selection order. **Right**: Compared with importance-driven FastV and redundancy-reduction DART and DivPrune at pruning rates of 66.7%, 77.8%, and 88.9%, VLM-Pruner consistently outperforms them across five VLMs.

![model](./fig/model.png)
**Figure 2. Centrifugal token pruning paradigm of VLM-Pruner. (a) Pipeline**: In the $i$-th decoder layer of the LLM, VLM-Pruner follows a near-to-far selection order, **(b)** starting with pivot tokens, **(c)** gradually expanding outward from neighborhoods, and **(d)** ultimately recovering the outermost information from the discarded tokens via SWA. The similarity computed under BSS criterion makes candidate tokens spatially closer to selected ones more likely to be chosen. Color transition from green to red indicates decreasing selection probability. $C$ and $S$ denote candidate and selected tokens, respectively. After applying BSS, the closer candidate $C_2$ is prioritized over $C_1$.

## 🌟 Citation

If you are interested in our work, please consider giving a 🌟 and citing our work below. We will update **VLM-Pruner** regularly.
```
@article{wu2025vlm,
  title={VLM-Pruner: Buffering for Spatial Sparsity in an Efficient VLM Centrifugal Token Pruning Paradigm},
  author={Wu, Zhenkai and Ma, Xiaowen and Ni, Zhenliang and Zhang, Dengming and Shu, Han and Jiang, Xin and Chen, Xinghao},
  journal={arXiv preprint arXiv:2512.02700},
  year={2025}
}
```

## 📮 Contact

If you are confused about the content of our paper or look forward to further academic exchanges and cooperation, please do not hesitate to contact us. The e-mail address is zkwu@zju.edu.cn. We look forward to hearing from you!

## 💡 Acknowledgement

Thanks to previous open-sourced repo:

- [LLaVA](https://github.com/haotian-liu/LLaVA)
- [Qwen2-VL](https://github.com/QwenLM/Qwen2-VL)
- [lmms-eval](https://github.com/EvolvingLMMs-Lab/lmms-eval)
- [DART](https://github.com/ZichenWen1/DART)
