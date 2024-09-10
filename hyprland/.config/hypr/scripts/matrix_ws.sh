matrix_size=3

##Utility functions

matrix_max=$(($matrix_size - 1))

function clamp() {
    n=$(($1 < 0 ? 0 : $1))
    n=$(($n > $matrix_max ? $matrix_max : $n))
    echo $n
}

function cycle() {
    echo $((($1 + $matrix_size) % $matrix_size))
}

##Get active workspace, and translate to rows and cols

active_ws=$(hyprctl monitors | grep "focused: yes" -B 10 | grep "active workspace" | awk -F': ' '{print $2}' | cut -d' ' -f1)

## Dealing with virtual desktops
number_of_monitors=$(xrandr -q | grep ' connected' | wc -l)

if [ "$number_of_monitors" -ne 1 ]; then
  echo "More than one monitor.."
  active_ws=$(awk "BEGIN {print int(($active_ws + 1) / $number_of_monitors)}")
fi

row=$((($active_ws - 1) / $matrix_size))
col=$((($active_ws - 1) % $matrix_size))

echo "$row : $col"

##Apply transformation
## change "cycle" to "clamp" to change the behavior

case $1 in
"up") row=$(clamp $(($row - 1))) ;;
"down") row=$(clamp $(($row + 1))) ;;
"left") col=$(clamp $(($col - 1))) ;;
*) col=$(clamp $(($col + 1))) ;;
esac

## translate col+row back to workspace number and apply

echo "$row : $col"
ws=$(($row * matrix_size + $col + 1))
echo $ws
# hyprctl dispatch workspace $ws
hyprctl dispatch vdesk $ws
