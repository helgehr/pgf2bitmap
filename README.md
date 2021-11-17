# pgf2bitmap

The script `pgf2bitmap.sh` takes an pgf formatted image and converts it into a bitmap file (`png`,`jpg`,..).

## Options
-d, --density<br>
&nbsp;&nbsp;&nbsp;&nbsp;Dpi, either for horizontal and vertical direction seperately (e.g. "300x400") or for both directions (e.g. "400").<br>
&nbsp;&nbsp;&nbsp;&nbsp;Defaults to "300"<br>
&nbsp;&nbsp;&nbsp;&nbsp;See also man page for `convert`<br>
-t, --type<br>
&nbsp;&nbsp;&nbsp;&nbsp;Type of output so e.g. "jpg"<br>
&nbsp;&nbsp;&nbsp;&nbsp;Defaults to png<br>

All other unrecognized given arguments are used as "output-options" for the `convert` command.

## Configuration
  I had to comment out the line `<policy domain="delegate" rights="none" pattern="gs" />` in the policy file of ImageMagick in `/etc/ImageMagick-7/policy.xml`. See [here](https://wiki.archlinux.org/title/ImageMagick).
