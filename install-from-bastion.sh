set -x

# Elevate priviledges, retaining the environment.
sudo -E su

# Install dev tools.
# vyum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel

# Get the OKD 3.11 installer.
pip install -I ansible==2.6.5
# Expect this to have been pushed by secure file transfer instead
# git clone -b release-3.11 https://github.com/openshift/openshift-ansible

# Run the playbook.
ANSIBLE_HOST_KEY_CHECKING=False /usr/local/bin/ansible-playbook -i ./inventory.cfg ./openshift-ansible/playbooks/prerequisites.yml
ANSIBLE_HOST_KEY_CHECKING=False /usr/local/bin/ansible-playbook -i ./inventory.cfg ./openshift-ansible/playbooks/deploy_cluster.yml

# If needed, uninstall with the below:
# /usr/local/bin/ansible-playbook playbooks/adhoc/uninstall.yml
