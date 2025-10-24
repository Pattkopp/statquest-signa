# Migration from Poetry to uv

This project has been successfully migrated from Poetry to `uv` for faster dependency management.

## What Changed

### Files Modified
- **pyproject.toml**: Converted from Poetry format to standard PEP 621 format
  - Removed `[tool.poetry]` sections
  - Removed `[build-system]` (not needed for notebook-only projects)
  - Updated to `[project]` format with proper authors
  
- **Dockerfile**: Updated to use `uv` instead of Poetry
  - Uses `uv sync` to install dependencies
  - Uses `uv run jupyter` to launch notebooks
  
- **README.md**: Added local setup instructions using `uv`

- **WARP.md**: Updated all references from Poetry to `uv`

### Files Added
- **.python-version**: Specifies Python 3.11 for `uv`
- **UV_MIGRATION.md**: This file

## Usage

### Local Development
```bash
# Install dependencies
uv sync

# Run Jupyter
uv run jupyter notebook

# Add new dependencies
uv add package-name

# Remove dependencies
uv remove package-name
```

### Docker
The Docker setup now uses `uv` internally:
```bash
docker build -t pytorch-jupyter .
docker run -p 8888:8888 --name jupyter-env pytorch-jupyter
```

## Benefits of uv

1. **Speed**: 10-100x faster than Poetry for dependency resolution
2. **Simplicity**: Native Python packaging standards (PEP 621)
3. **Compatibility**: Works seamlessly with pip and standard Python tooling
4. **Modern**: Written in Rust, actively maintained by Astral

## Notes

- No `uv.lock` file is committed yet - it will be generated on first `uv sync`
- All dependencies remain the same as before
- The project is configured as a notebook collection, not a package
- **Python Version**: Upgraded from 3.11 to 3.13 (Python 3.14 not yet fully supported by all dependencies like `llvmlite`)
