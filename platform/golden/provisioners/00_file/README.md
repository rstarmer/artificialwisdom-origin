Artificial Wisdom™ Golden Image Overlay for Oracle Cloud Infrastructure

# Overview

Oracle platform images are limited to Oracle Linux, Red Hat Enterprise Linux, SUSE,
and Ubuntu. Our cloud is based upon Debian. Oracle Cloud Infrastructure has extensive
[documentation](https://github.com/artificialwisdomai/origin/wiki/OCI-Image-Documentation) explaining how to bring your own image to Oracle Cloud. Unfortunately, there are
not many code patterns describing how to build a custom image and use it within OCI.

This document doesn't describe all of the mechanics of building a custom iamge to
run with Oracle Cloud Infrastructure. What we do instead is provide instructions that
explain how to build an overlay of the changes made to Ubuntu, and then apply them
to Debian.

# Workflow

## Create an overlay list

There are several apporaches to creating an overlay list. The aproach here searches
for a specific text string used to identify modified files. Every file that is
modified for Oracle Cloud Infrastructure's Ubuntu image contains the singnature
`CLOUD_IMG`.

- Create an instance with the latest Ubuntu image on an Intel shape:

```console
TODO
login to the virtual machine
```

- Create an archive of the filesystem:

```console
sudo tar -czvf /tmp/oracle_cloud_infrastructure_ubuntu_22_04.tar.gz --exclude /tmp --exclude /run --exclude /dev --exclude /proc
exit (to logout of the virtual machine)
```

- Copy the archive to a local system:

```console
scp ubuntu@instance_ip:/tmp/oracle_cloud_infrastructure_ubuntu_22_04.tar.gz $HOME
```

- extract the archive

```console
mkdir $HOME/oracle_cloud_infrastructure_ubuntu_22_04_rootdisk
pushd $HOME/oracle_cloud_infrastructure_ubuntu_22_04_rootdisk
tar -xzvf $HOME/oracle_cloud_infrastructure_ubuntu_22_04.tar.gz
```

- Replicate all files

```console
grep -rl CLOUD_IMG * | xargs -t -I % install -D % artificialwisdom_cloud/%
```

- Create an overlay tarball

```console
pushd $HOME/artificialwisdom_cloud
tar -czvf $HOME/repos/origin/platform/golden/provisioners/00_file/artificialwisdom_cloud_oracle_cloud_overlay.tar.gz .
popd
```

- Clean up the shell stack

```console
popd
```

- Build the Artificial Wisdom™ Cloud golden image

*NB* Ensure you have a functional installation of Oracle VirtualBox and Packer.

```console
cd $HOME/repos/origin/platform/golden
bash ./run.sh
```
