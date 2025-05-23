#! /bin/bash
#
# https://forum.manjaro.org/t/root-tip-utility-script-gio-mount-samba-share/100723
#
#
#  User script for mounting and unmounting a samba share 
#
#  - No fstab entry
#  - No mount units
#  - Easy customization
#  - Symlinks are located in designated folder (default: $HOME/SMBLinks)
#  - Symlink can be named  (default: $SHARENAME)
#  - Using `-u` argument will unmount and remove the symlink
#  - Option for providing credentials
#  - Option for a user service to mount at login
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# @linux-aarhus - root.nix.dk
#

###########################################
# NECESSARY -  MODIFY THESE VARIABLES

# your samba server's hostname or IP address
HOST="192.168.1.141"

# the share name on the server
SHARENAME="share"

# credentials
USERNAME=bruno
WORKGROUP=
PASSWD=4460

###########################################
# don't modify below this line 
#  - unless you know what you are doing

LINKNAME="$SHARENAME"
SYMLINKS="$HOME/SMB"
SCRIPTNAME=$(basename "$0")
VERSION="0.2"

# check argument $1
if [[ "$1" == "-u" ]]; then
    # remove symlink
    rm -f "$SYMLINKS/$LINKNAME"
    # unmount share
    gio mount -u "smb://$HOST/$SHARENAME"
    exit
elif [[ $1 != "" ]]; then
    echo ":: $SCRIPTNAME v$VERSION"
    echo "==> invalid argument: $1"
    echo "Usage: "
    echo "  mount SMB : $SCRIPTNAME"
    echo "  umount SMB: $SCRIPTNAME -u"
    exit 1
fi

# Create credentials folder
if ! [ -d "$HOME/.credentials" ]; then
    mkdir -p $HOME/.credentials
    chmod 700 $HOME/.credentials
fi

# ----------------------------------------------------------------
# mount command
if ! [[ -z "${USERNAME}" ]]; then
    # create credentials file
    fname="$HOME/.credentials/$USERNAME-$HOST-$SHARENAME"
    printf ${USERNAME}'\n'${WORKGROUP}'\n'${PASSWD}'\n' > $fname
    chmod 600 $fname
    # mount and feed the credentials to the mount command
    gio mount "smb://$HOST/$SHARENAME" < $fname
else
    # mount (if credentials are required you will be prompted
    gio mount "smb://$HOST/$SHARENAME"
fi
# ----------------------------------------------------------------

# easy reference to gio mount point
ENDPOINT=/run/user/$UID/gvfs/''smb-share:server=$HOST,share=$SHARENAME''

# crete the subfolder
if ! [ -d "$SYMLINKS" ]; then
    # use --parents to suppress warnings if folder exist
    mkdir -p "$SYMLINKS"
fi

# use --force argument to suppress warning if link exist
ln -sf "$ENDPOINT" "$SYMLINKS/$LINKNAME"
