# get-next-version

Get the latest git tag in a repository and return the next patch version.

# Testing

```bash
cd .github/actions/get-next-version
python3 -m venv .venv
. ./.venv/bin/activate
pip install --requirement requirements.txt
python3 -m unittest discover . -p 'test_*.py'
```
