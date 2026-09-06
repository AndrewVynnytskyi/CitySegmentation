# Cityscapes Segmentation — DeepLabV3+

DeepLabV3+ (custom ASPP and decoder on an ImageNet-pretrained Xception encoder) for 19-class
street-scene segmentation on [Cityscapes](https://www.cityscapes-dataset.com/). Everything lives in
one notebook, [`CitySegmentation.ipynb`](CitySegmentation.ipynb), built to run on a Colab T4.
A portfolio and personal-study project.

The comparison the notebook is built around is frozen versus fine-tuned encoder: the same
architecture trained twice, once with the pretrained Xception held fixed and once with it
unfrozen at a lower learning rate.

## Structure

```
CitySegmentation.ipynb    # the whole project: architecture, training loop, planned experiments
pyproject.toml            # project metadata, dependencies, Ruff config
requirements.txt          # same dependencies, pip format
Makefile                  # setup / lint / format targets
.gitignore                # dataset, checkpoints, caches, PyCharm files
.pre-commit-config.yaml   # pre-commit hooks (the notebook is excluded)
LICENSE                   # MIT
data/                     # empty; the notebook extracts Cityscapes here (gitignored)
models/                   # empty; checkpoints are written here (gitignored)
```

## How to run

Open `CitySegmentation.ipynb` in Colab, set Runtime → Change runtime type → **T4 GPU**, and run the
cells top to bottom. The download cell needs a free account at
[cityscapes-dataset.com](https://www.cityscapes-dataset.com/); `csDownload` prompts for those
credentials itself. Checkpoints and `experiment_meta.json` are mirrored to Google Drive under
`MyDrive/CityscapesSegmentation-experiment`, and a rerun resumes from the last completed epoch rather
than starting over.

Lint and format targets:

```bash
make setup
make lint
make format
```

## Status

Work in progress.

- **Works**: the architecture cells, the labelId→trainId mapping, the dataset/transform pipeline, and
  the training loop. The saved output of the training cell in
  [`CitySegmentation.ipynb`](CitySegmentation.ipynb) records a real Colab run: it reports the
  frozen-encoder variant as complete at 88/88 epochs, and the fine-tuned variant at epoch 41 of 154
  when the notebook was saved.
- **Incomplete**: the fine-tuned run stopped at epoch 41 of 154, so there are no final mIoU numbers
  for either variant to compare. The three interpretation cells and the concluding section are
  unwritten.
- **Untested**: the Grad-CAM and failure-case cells have never been executed — they run after
  training finishes and carry no output.
- The notebook targets Colab specifically: the Drive mount and the `!pip install` cells assume that
  runtime, and there is no local entry point. `requirements.txt` leaves `albumentations`, `timm`,
  `grad-cam` and `cityscapesscripts` unpinned so they resolve against whatever Colab currently ships.
- The lint targets above have not been run against this repo.
- The from-scratch `XceptionModel` in the early cells is kept as an architecture reference and is not
  used for training; `PretrainedXceptionEncoder` (timm) is what the training cells build.
- `CityScapsDataset` and `transforms_deep_lab_v3` in the first two cells are superseded by
  `CityscapesDataset` and `train_transforms`/`val_transforms` further down. The notebook's markdown
  explains why; both versions are left in place.

## License

MIT — see [LICENSE](LICENSE).
