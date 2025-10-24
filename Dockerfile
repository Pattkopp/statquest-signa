# Use the official Python 3.13 image
FROM python:3.13

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PATH="/root/.local/bin:$PATH"

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set working directory
WORKDIR /notebooks

# Copy pyproject.toml first for better Docker layer caching
COPY pyproject.toml /notebooks/

# Initialize uv project and sync dependencies
RUN uv sync

# Copy all repo files into /notebooks/
COPY . /notebooks/

# Expose Jupyter Notebook port
EXPOSE 8888

# Run Jupyter when the container starts
CMD ["uv", "run", "jupyter", "notebook", "--ip=*******", "--port=8888", "--allow-root", "--NotebookApp.token=''"]
