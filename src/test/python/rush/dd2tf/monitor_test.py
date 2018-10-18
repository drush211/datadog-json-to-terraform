"""
Module used to test out the monitor module for converting monitor json into monitor terraform.
"""

import pytest

from unittest import TestCase

from rush.dd2tf.monitor import Monitor
from testing_utils import resource_file_contents


@pytest.mark.unit
class MonitorTest(TestCase):
    """
    Class used to test converting a monitor in json to a monitor in terraform.
    """

    def test_basic_monitor_json_to_terraform(self):
        """
        Test to ensure we can take a simple monitor from json to terraform.
        """
        basic_monitor_exported_dict = {
            "name": "Basic Datadog Metric Count: 2",
            "type": "query alert",
            "query": "some query",
            "message": "Some Message about how to\n\n handle it.",
            "tags": [
                "tag:1",
                "tag:2"
            ],
            "options": {
                "notify_audit": False,
                "locked": True,
                "silenced": {},
                "include_tags": True,
                "renotify_interval": 0,
                "thresholds": {
                    "critical": 2,
                    "warning": 3,
                    "warning_recovery": 4,
                    "critical_recovery": 3
                },
                "escalation_message": "escalation\n\n message",
                "no_data_timeframe": 2,
                "new_host_delay": 300,
                "require_full_window": True,
                "notify_no_data": False
            }
        }
        monitor = Monitor(basic_monitor_exported_dict)
        expected_terraform = resource_file_contents("basic_monitor.tf")
        self.assertEqual(
            monitor.to_terraform(),
            expected_terraform
        )
