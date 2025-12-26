<div align="center">

# VLM-Pruner: Buffering for Spatial Sparsity in an Efficient VLM Centrifugal Token Pruning Paradigm

**Zhenkai Wu**<sup>1,2</sup><sup>†</sup> &nbsp;
**Xiaowen Ma**<sup>2</sup><sup>†</sup> &nbsp;
**Zhenliang Ni**<sup>2</sup>  

**Dengming Zhang**<sup>1,2</sup> &nbsp;
**Han Shu**<sup>2</sup> &nbsp;
**Xin Jiang**<sup>2</sup> &nbsp;
**Xinghao Chen**<sup>2</sup><sup>✉</sup>

<sup>1</sup> Zhejiang University  
<sup>2</sup> Huawei Noah’s Ark Lab  

<sup>†</sup> Equal contribution.  
<sup>✉</sup> Corresponding author: xinghao.chen@huawei.com

</div>




## Note
The usage is coming soon in December 2025!

## 🔥 News
- `2025/12/15`: The official implementation of VLM-Pruner is available!
- `2025/12/02`: VLM-Pruner has been submitted to Arxiv, see [here](https://arxiv.org/abs/2512.02700). 

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
