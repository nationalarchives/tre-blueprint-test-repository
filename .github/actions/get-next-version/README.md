# get-next-version

GitHub action and supporting script to return the next version number by
incrementing the patch number of the latest Git tag. An optional suffix can be
appended (e.g. "beta" for "1.2.3-beta").

# Testing

```bash
cd .github/actions/get-next-version
python3 -m venv .venv
. ./.venv/bin/activate
pip install --requirement requirements.txt
python3 -m unittest discover . -p 'test_*.py'
```
