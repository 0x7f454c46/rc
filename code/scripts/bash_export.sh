# file to be exported from ~/.bashrc
# pipes 4fun

# machine-dependence
MACHINE_NAME=$(uname -n)
NOTEBOOK_NAME=jimi

function pipes()
{
	~/code/scripts/pipes.sh -p3 -r6000
}

function invaiders()
{
	~/code/scripts/invaiders.sh
}

function mount_smb()
{
	mkdir -p /tmp/samba/
	smbnetfs -o direct_io,readdir_ino /tmp/samba/
}

if [[ "${MACHINE_NAME}" == "${NOTEBOOK_NAME}" ]]
then
function set_wallpaper()
{
	hsetroot -fill "$1"
}
else
function set_wallpaper()
{
	convert -crop '50%x100%' +repage $1 $1
	first="${1%.*}-0.${1#*.}"
	second="${1%.*}-1.${1#*.}"
	feh --bg-scale "$first" --bg-scale "$second"
	rm "$first" "$second"
}
fi
