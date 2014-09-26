#!/usr/bin/env bash

# Copyright (c) 2013 Martin Abente Lahaye. - tch@sugarlabs.org
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

package=$1
spec=$package/$package.spec

if [ ! -f $spec ]; then
    echo "[ERROR]: "$spec" no found."
    exit -1
fi

echo "[INFO] Reading package from "$spec"."
name=$(grep "Name:" $spec | awk '{print $2;}')
version=$(grep "Version:" $spec | awk '{print $2;}')
tarball=$(grep "Source0:" $spec | awk '{print $2;}')

url=$(grep "GitUrl:" $spec | awk '{print $2;}')
commit=$(grep "GitCommit:" $spec | awk '{print $2;}')

echo $name
echo $version
echo $tarball
echo $url
echo $commit

rm -rf ./tmp > /dev/null 2>&1
mkdir ./tmp > /dev/null 2>&1
cd ./tmp/

    git clone $url $name-$version

    cd $name-$version

        git reset --hard $commit
        rm -rf .git/

        if [ -f "autogen.sh" ]; then
            echo "[INFO] Running autogen."
            ./autogen.sh > /dev/null 2>&1
        fi

    cd ../

    echo "[INFO] Creating tarball."
    tar -cvf $tarball $name-$version > /dev/null 2>&1
    mv $tarball ${HOME}/rpmbuild/SOURCES/

cd ../

srcrpm=$(rpmbuild -bs $spec |  awk '{print $2;}')
echo $srcrpm
