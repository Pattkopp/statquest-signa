# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is the companion code repository for **The StatQuest Illustrated Guide to Neural Networks and AI** by Josh Starmer. It contains PyTorch tutorials that progressively build understanding of neural networks from basic concepts to advanced transformers.

## Environment Setup

### Docker (Recommended)
```bash
# Make install script executable
chmod +x install_docker.sh

# Install Docker, Buildx, and Compose (Linux/Ubuntu/WSL2)
./install_docker.sh

# Build the Docker image
docker build -t pytorch-jupyter .

# Run Jupyter with all dependencies
docker run -p 8888:8888 --name jupyter-env pytorch-jupyter

# Access notebooks at http://localhost:8888/
```

### Dependencies
All dependencies are managed via `uv` (see `pyproject.toml`):
- **PyTorch**: Core neural network framework
- **Lightning**: Simplifies PyTorch training loops and optimization
- **matplotlib/seaborn**: Visualization
- **pandas/scikit-learn**: Data manipulation and utilities
- **bertopic/datasets**: NLP utilities
- **jupyter**: Notebook environment

## Code Structure

### Chapter Organization
The repository is organized by book chapters, each containing self-contained Jupyter notebooks:

- **chapter_01-02**: Basic neural networks and backpropagation fundamentals
- **chapter_03-05**: Multiple inputs/outputs, SoftMax, ArgMax, Cross Entropy
- **chapter_06**: Convolutional Neural Networks (CNNs) for image classification
- **chapter_08**: Long Short-Term Memory (LSTMs) for sequence prediction
- **chapter_09**: Word embeddings
- **chapter_10-11**: Seq2Seq models and attention mechanisms
- **chapter_12**: Encoder-Decoder Transformers
- **chapter_13**: Decoder-Only Transformers
- **chapter_14**: Encoder-Only Transformers

### Neural Network Patterns

All tutorials follow a consistent structure:

1. **Import modules**: torch, torch.nn, torch.nn.functional, lightning
2. **Define custom classes**: Inherit from `nn.Module` with `__init__()` and `forward()` methods
3. **Training setup**: Use Lightning's `LightningModule` for training loops
4. **Data loading**: Use `TensorDataset` and `DataLoader` from torch.utils.data
5. **Optimization**: Typically use Adam optimizer from torch.optim

### Key Architectural Patterns

#### Basic Neural Network Structure
```python
class MyNN(nn.Module):
    def __init__(self):
        super().__init__()
        # Initialize weights, biases, layers
        
    def forward(self, input_values):
        # Define forward pass computation
        return output_values
```

#### Lightning Training Structure
For chapters 8+, models use Lightning's training framework:
```python
class MyModel(L.LightningModule):
    def __init__(self):
        super().__init__()
        # Model components
        
    def forward(self, x):
        # Forward pass
        
    def training_step(self, batch, batch_idx):
        # Training logic
        
    def configure_optimizers(self):
        # Return optimizer
```

#### Transformer Components
Advanced chapters (10-14) implement transformers from scratch with these components:
- **PositionEncoding**: Uses sine/cosine curves to encode token positions
- **Attention**: Implements scaled dot-product attention mechanisms
- **Encoder/Decoder**: Separate classes for encoding input and generating output
- **Complete Transformer**: Combines all components

## Running Notebooks

### Google Colab / Lightning Studio
Each notebook has direct links to run in cloud environments (see README.md chapter table).

### Local Jupyter
```bash
# Inside Docker container (already set up)
# Access via http://localhost:8888/

# Or install locally with uv
uv sync
uv run jupyter notebook
```

## Working with This Codebase

### When Adding New Tutorials
- Follow the existing chapter_XX naming convention
- Include detailed markdown explanations alongside code
- Use `%%capture` to suppress verbose installation output
- Add pre-trained weights as `torch.tensor()` objects for educational examples
- Include visual diagrams hosted on GitHub (chapter_XX/images/)

### When Modifying Models
- All models are built from scratch for educational purposes
- Do not replace custom implementations with library functions (e.g., keep manual attention implementation instead of using torch.nn.MultiheadAttention)
- Maintain verbose comments explaining each step
- Keep examples simple and focused on core concepts

### Testing Changes
- No automated test suite exists (this is a tutorial repository)
- Manually run notebooks end-to-end to verify changes
- Check that visualizations render correctly
- Ensure training loops complete without errors

## Important Notes

### Educational Purpose
This codebase prioritizes **clarity over efficiency**. Implementations are intentionally verbose and build components from scratch to demonstrate underlying concepts, even when PyTorch provides built-in alternatives.

### Pre-trained Values
Many early chapters use pre-trained weights/biases (hardcoded as `torch.tensor()` values) to focus on forward pass mechanics before introducing training.

### Data
Simple datasets are used throughout:
- Basic chapters: Synthetic data defined directly in notebooks
- Advanced chapters: Simple vocabulary dictionaries for language tasks
- Some chapters include small data files (e.g., `iris.txt` in chapters 3-4)

### Dependencies on Book Content
The notebooks assume familiarity with corresponding book chapters and reference figures/diagrams from the book. Code comments frequently reference "as seen in the book" or "as illustrated in Chapter X".
