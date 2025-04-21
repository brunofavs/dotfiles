#!/bin/bash

pw-loopback -m '[ FL FR]' --playback-props='media.class=Audio/Source node.name=audio-relay-mic' & pid=$!; audiorelay %U; kill $pid
