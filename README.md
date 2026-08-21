# Cityscapes Segmentation — DeepLabV3+

DeepLabV3+ (custom ASPP + decoder, ImageNet-pretrained Xception encoder) trained on [Cityscapes](https://www.cityscapes-dataset.com/) for 19-class street-scene segmentation. See [`CitySegmentation.ipynb`](CitySegmentation.ipynb).

## Architecture

- **Decoder / ASPP**: custom from-scratch implementation (`SeparableConv`, `ASPP`, `DecoderBlock`).
- **Encoder**: a from-scratch `XceptionModel` (16 middle-flow blocks, no pretrained weights) is kept in the notebook as the original architecture reference, but **not used for training** — training a backbone this deep from random initialization needs far more compute than a Colab session allows (see the time estimate below). An ImageNet-pretrained Xception (`timm`) is used instead, same pivot as the companion [SAR-Ship-Segmentation](../SAR-Ship-Segmentation) project.
- **Labels**: raw `gtFine_labelIds` (34 IDs) are mapped to the standard 19 Cityscapes train classes + ignore index, matching the published benchmark protocol.

## Experiments

1. **Transfer learning** — frozen vs. fine-tuned pretrained encoder
2. **Grad-CAM** — per-class activation (defaults to `car`; swap to a thin class like `pole`/`motorcycle` for a harder case)
3. **Failure case analysis** — high-confidence, low-mIoU validation images

Each has a "Write here" markdown cell for your own interpretation.

## Compute budget

Training is sized to use roughly **~25 hours of T4 time** (≈27-28 compute units at your observed ~1.1 units/hour rate) — see the "Compute budget" markdown cell in the notebook for the epoch-count reasoning (`EPOCHS_FROZEN=88`, `EPOCHS_FINETUNED=154`). Estimated, not measured; watch Colab's usage panel after the first few epochs and adjust those two constants if the real per-epoch time is off from the ~6 min/epoch assumption.

## Results

_Fill in after running the notebook._

| Variant | Val mIoU |
|---|---|
| Frozen encoder | _fill in_ |
| Fine-tuned | _fill in_ |

## Running it

1. Open `CitySegmentation.ipynb` in Colab. Runtime → Change runtime type → **T4 GPU**.
2. Run top to bottom. The Cityscapes download cell requires a free account at [cityscapes-dataset.com](https://www.cityscapes-dataset.com/) (no Kaggle-style anonymous mirror, unlike HRSID) — verify the `csDownload` CLI flags yourself before relying on that cell, they're noted as unverified in the notebook.
3. Checkpoints/metrics mirror to Google Drive (`/content/drive/MyDrive/CityscapesSegmentation-experiment`), so a disconnected/restarted runtime resumes instead of retraining from scratch.

**Linting** (for any future `.py` scripts — the notebook itself is excluded from Ruff/pre-commit):
```bash
make setup
make lint
make format
```

## Repo structure

```
CitySegmentation.ipynb   # architecture (reference) + training pipeline + experiments
requirements.txt         # torch, opencv-python, albumentations
pyproject.toml            # Ruff config, project metadata
.pre-commit-config.yaml   # pre-commit hooks (notebook excluded)
```

## Related

Shares its ASPP/decoder design with [SAR-Ship-Segmentation](../SAR-Ship-Segmentation) (HRSID, SAR ship segmentation) — same architecture, same pretrained-encoder pivot, different domain.

## License

MIT — see [LICENSE](LICENSE).
