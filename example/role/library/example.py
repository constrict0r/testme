#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, constrict0r <constrict0r@protonmail.com>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt).

from ansible.module_utils.basic import AnsibleModule

ANSIBLE_METADATA = {
    'metadata_version': '1.1',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: example

short_description: Example Ansible Module.

version_added: "2.8"

description:
    - "Join words into a single string."

options:
    items:
        description:
            - List of items to be joined on a single string.

author:
    - constrict0r (@constrict0r)
'''

EXAMPLES = '''
# Join two words.
- name: Join two words.
  items: [one, two]
  register: single_result

# Join three words.
- name: Join three words.
  items: [one, two, three]
  register: single_result
'''

RETURN = '''
single:
    description: A single joined string.
    type: string
    returned: always
'''


def run_module():
    """Runs the module.

    Args:
        items (list): List of items to concatenate.

    Returns:
        string: Single concatenated string.
    """

    module_args = dict(
        items=dict(type='list', required=False, default=[])
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    single = ''

    result = dict(
        single='',
        changed=False
    )

    for item in module.params['items']:
        single = ', '.join([single, item])

    if single:
        result['single'] = single
        result['changed'] = True

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
