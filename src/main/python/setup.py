"""
Install script used to package this module. Nothing special here, just package everything and include the requirements.
"""

import os

from setuptools import setup, find_packages


def main():
    """
    Build the whl file.
    """
    main_source_dir = os.environ.get("PYTHON_SOURCE", ".")
    setup(
        name="datadog-to-terraform",
        version=os.environ.get("BUILD_VERSION", "1.0.0"),
        url="http://github.com/drush211/datadog-json-to-terraform",
        scripts=[
            "/scripts/convert_datadog_json_to_terraform",
        ],
        packages=find_packages(main_source_dir),
        package_dir={"": main_source_dir},
        install_requires=[],
        python_requires=">=3.6, <4"
    )


if __name__ == "__main__":
    main()
