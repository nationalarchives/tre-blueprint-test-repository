import requests
import semver


def get_next_version(
        repo_name: str,
        version_suffix: str=None,
        github_api_url: str='https://api.github.com',
        github_repo_prefix: str='/repos/nationalarchives/',
        github_repo_suffix: str='/tags',
        version_if_no_tags: str='0.0.1'
):
    """
    Get the latest git tag in `repo_name` and return the next patch version,
    or `version_if_no_tags` if no existing tags found. An optional
    `version_suffix` can be appended (e.g. to return "1.2.3-alpha" or
    "1.2.3-ceebe6c" instead of just "1.2.3").
    
    Examples:
    * If the latest tag in `repo_name` is "2.3.3", "2.3.4" would be returned
    * If the latest tag in `repo_name` is "2.3.3", and "ceebe6c" is passed as
      the `version_suffix` argument, "2.3.4-ceebe6c" would be returned
    """
    tag_url = f'{github_api_url}{github_repo_prefix}{repo_name}{github_repo_suffix}'
    response = requests.get(tag_url)
    response.raise_for_status()  # raise error if response not OK
    response_json = response.json()

    # Check have expected list of items
    if not isinstance(response_json, list):
        raise ValueError('Tag list is not a JSON list type')

    # Set a default value; overwritten unless no existing tags found
    next_version = semver.VersionInfo.parse(version_if_no_tags)

    # Check for existing tags
    if len(response_json) > 0:
        latest_tag_record = response_json[0]
        KEY_NAME = 'name'
        if KEY_NAME not in latest_tag_record:
            raise ValueError(f'Latest record does not have key "{KEY_NAME}"')

        latest_tag_version = latest_tag_record[KEY_NAME]
        next_version = semver.VersionInfo.parse(latest_tag_version).bump_patch()

    # Return the new version, with optional version_suffix
    return str(next_version.replace(prerelease=version_suffix))
