#!/bin/sh
#
# Kindle Touch/PaperWhite JailBreak Install
#
# $Id: 5.4-install.sh 12225 2015-08-17 13:47:22Z NiLuJe $
#
##


# Pull some helper functions for logging
source /etc/upstart/functions

VARLOCAL_OOS="false"

LOG_DOMAIN="jb_install"

logmsg()
{
	f_log "${1}" "${LOG_DOMAIN}" "${2}" "${3}" "${4}"
}

RW=
mount_rw() {
	if [ -z "$RW" ] ; then
		RW=yes
		mount -o rw,remount /
	fi
}

mount_ro() {
	if [ -n "$RW" ] ; then
		RW=
		mount -o ro,remount /
	fi
}

mount_root_rw()
{
	logmsg "I" "mount_root_rw" "" "Mounting rootfs rw"
	mount_rw
}

IS_TOUCH="false"
IS_PW="false"
IS_PW2="false"
IS_KV="false"
IS_KT2="false"
IS_PW3="false"
K5_ATLEAST_54="false"
check_model()
{
	# Do the S/N dance...
	kmodel="$(cut -c3-4 /proc/usid)"
	case "${kmodel}" in
		"24" | "1B" | "1D" | "1F" | "1C" | "20" )
			# PaperWhite 1 (2012)
			IS_PW="true"
		;;
		"D4" | "5A" | "D5" | "D6" | "D7" | "D8" | "F2" | "17" | "60" | "F4" | "F9" | "62" | "61" | "5F" )
			# PaperWhite 2 (2013)
			IS_PW="true"
			IS_PW2="true"
		;;
		"13" | "54" | "2A" | "4F" | "52" | "53" )
			# Voyage...
			IS_KV="true"
		;;
		"C6" | "DD" )
			# KT2...
			IS_TOUCH="true"
			IS_KT2="true"
		;;
		"0F" | "11" | "10" | "12" )
			# Touch
			IS_TOUCH="true"
		;;
		* )
			# Try the new device ID scheme...
			kmodel="$(cut -c4-6 /proc/usid)"
			case "${kmodel}" in
				"0G1" | "0G2" | "0G4" | "0G5" | "0G6" | "0G7" )
					# PW3...
					IS_PW3="true"
				;;
				* )
					# Fallback... We shouldn't ever hit that.
					IS_TOUCH="true"
				;;
			esac
		;;
	esac

	# Use the proper constants for our screen...
	if [ "${IS_KV}" == "true" -o "${IS_PW3}" == "true" ] ; then
		SCREEN_X_RES=1088
		SCREEN_Y_RES=1448
		EIPS_X_RES=16
		EIPS_Y_RES=24
	elif [ "${IS_PW}" == "true" ] ; then
		SCREEN_X_RES=768
		SCREEN_Y_RES=1024
		EIPS_X_RES=16
		EIPS_Y_RES=24
	elif [ "${IS_KT2}" == "true" ] ; then
		SCREEN_X_RES=608
		SCREEN_Y_RES=800
		EIPS_X_RES=16
		EIPS_Y_RES=24
	else
		SCREEN_X_RES=600
		SCREEN_Y_RES=800
		EIPS_X_RES=12
		EIPS_Y_RES=20
	fi
	EIPS_MAXCHARS="$((${SCREEN_X_RES} / ${EIPS_X_RES}))"
	EIPS_MAXLINES="$((${SCREEN_Y_RES} / ${EIPS_Y_RES}))"
}

check_version()
{
	# The great version check!
	kpver="$(grep '^Kindle 5' /etc/prettyversion.txt 2>&1)"
	if [ $? -ne 0 ] ; then
		logmsg "W" "check_version" "" "couldn't detect the kindle major version!"
		# We're in a bit of a pickle... Make an educated guess...
		if [ "${IS_PW2}" == "true" ] ; then
			# The PW2 shipped on 5.4.0 ;)
			logmsg "I" "check_version" "" "PW2 detected, assuming >= 5.4"
			K5_ATLEAST_54="true"
		elif [ "${IS_KV}" == "true" ] ; then
			# The KV shipped on 5.5.0 ;)
			logmsg "I" "check_version" "" "KV detected, assuming >= 5.4"
			K5_ATLEAST_54="true"
		elif [ "${IS_KT2}" == "true" ] ; then
			# The KT2 shipped on 5.6.0 ;)
			logmsg "I" "check_version" "" "KT2 detected, assuming >= 5.4"
			K5_ATLEAST_54="true"
		elif [ "${IS_PW3}" == "true" ] ; then
			# The PW3 shipped on 5.6.1 ;)
			logmsg "I" "check_version" "" "PW3 detected, assuming >= 5.4"
			K5_ATLEAST_54="true"
		else
			# Poor man's last resort trick. See if we can find a new feature of FW 5.4 on the FS...
			if [ -f /etc/upstart/contentpackd.conf ] ; then
				logmsg "I" "check_version" "" "found a fw >= 5.4 feature"
				K5_ATLEAST_54="true"
			fi
		fi
	else
		# Weeee, the great case switch!
		khver="$(echo ${kpver} | sed -n -r 's/^(Kindle)([[:blank:]]*)([[:digit:].]*)(.*?)$/\3/p')"
		case "${khver}" in
			5.0* )
				K5_ATLEAST_54="false"
			;;
			5.1* )
				K5_ATLEAST_54="false"
			;;
			5.2* )
				K5_ATLEAST_54="false"
			;;
			5.3* )
				K5_ATLEAST_54="false"
			;;
			5.4* )
				K5_ATLEAST_54="true"
			;;
			5.5* )
				K5_ATLEAST_54="true"
			;;
			5.6* )
				K5_ATLEAST_54="true"
			;;
			5.* )
				# Assume newer, just to be safe ;)
				K5_ATLEAST_54="true"
			;;
			* )
				# Given the previous checks, this shouldn't be reachable, but cover all bases anyway...
				logmsg "W" "check_version" "" "couldn't detect the kindle version!"
				# Poor man's last resort trick. See if we can find a new feature of FW 5.4 on the FS...
				if [ -f /etc/upstart/contentpackd.conf ] ; then
					logmsg "I" "check_version" "" "found a fw >= 5.4 feature"
					K5_ATLEAST_54="true"
				fi
			;;
		esac
	fi
}

print_jb_install_feedback()
{
	# Prepare our stuff... Print an extra warning if we failed to setup the bridge and/or MKK...
	if [ "${VARLOCAL_OOS}" == "true" ] ; then
		kh_eips_string="**** JB - WARNING: BRIDGE SETUP FAILED ****"
	else
		kh_eips_string="**** JAILBREAK ****"
	fi

	# And finally, show our message, centered on the bottom of the screen
	eips $(((${EIPS_MAXCHARS} - ${#kh_eips_string}) / 2)) $((${EIPS_MAXLINES} - 2)) "${kh_eips_string}"
}

install_update_key()
{
	logmsg "I" "install_update_key" "" "Copying the jailbreak updater key"
	cat > "/etc/uks/pubdevkey01.pem" << EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJn1jWU+xxVv/eRKfCPR9e47lP
WN2rH33z9QbfnqmCxBRLP6mMjGy6APyycQXg3nPi5fcb75alZo+Oh012HpMe9Lnp
eEgloIdm1E4LOsyrz4kttQtGRlzCErmBGt6+cAVEV86y2phOJ3mLk0Ek9UQXbIUf
rvyJnS2MKLG2cczjlQIDAQAB
-----END PUBLIC KEY-----
EOF
}

install_fw54_exec_userstore_flag()
{
	# FW >= 5.4 only...
	if [ "${K5_ATLEAST_54}" == "true" ] ; then
		logmsg "I" "install_fw54_exec_userstore_flag" "" "Creating the userstore exec flag file"
		touch "/MNTUS_EXEC"
	fi
}

install_bridge()
{
	logmsg "I" "install_bridge" "" "Installing the jailbreak bridge"
	if [ "$(df -k /var/local | awk '$3 ~ /[0-9]+/ { print $4 }')" -lt "512" ] ; then
		# Hu ho... Keep track of this...
		VARLOCAL_OOS="true"
		logmsg "W" "install" "" "Failed to setup the jailbreak bridge: not enough space left on device"
	else
		cp -f "/mnt/us/bridge.sh" "/var/local/system/fixup"
		chmod a+x "/var/local/system/fixup"
	fi

	# And the bridge job...
	cp -f "/mnt/us/bridge.conf" "/etc/upstart/bridge.conf"
	chmod 0664 "/etc/upstart/bridge.conf"
}

install_persistent_mkk()
{
	MKK_PERSISTENT_STORAGE="/var/local/mkk"
	MKK_BACKUP_STORAGE="/mnt/us/mkk"
	logmsg "I" "install" "" "Setting up MKK persistent copy"
	if [ "$(df -k /var/local | awk '$3 ~ /[0-9]+/ { print $4 }')" -lt "512" ] ; then
		# Hu ho... Keep track of this...
		VARLOCAL_OOS="true"
		logmsg "W" "install" "" "Failed to setup MKK persistent copy: not enough space left on device"
	else
		mkdir -p "${MKK_PERSISTENT_STORAGE}"
		cp -f "/mnt/us/developer.keystore" "${MKK_PERSISTENT_STORAGE}/developer.keystore"
		cp -f "/mnt/us/json_simple-1.1.jar" "${MKK_PERSISTENT_STORAGE}/json_simple-1.1.jar"
		cp -f "/mnt/us/gandalf" "${MKK_PERSISTENT_STORAGE}/gandalf"
		cp -f "/mnt/us/bridge.sh" "${MKK_PERSISTENT_STORAGE}/bridge.sh"
		cp -f "/mnt/us/bridge.conf" "${MKK_PERSISTENT_STORAGE}/bridge.conf"

		chmod a+x "${MKK_PERSISTENT_STORAGE}/gandalf"
		chmod +s "${MKK_PERSISTENT_STORAGE}/gandalf"
		ln -sf "${MKK_PERSISTENT_STORAGE}/gandalf" "${MKK_PERSISTENT_STORAGE}/su"

		rm -rf "${MKK_BACKUP_STORAGE}"
		mkdir -p "${MKK_BACKUP_STORAGE}"
		for my_file in ${MKK_PERSISTENT_STORAGE}/* ; do
			if [ -f ${my_file} -a ! -L ${my_file} ] ; then
				cp -f "${my_file}" "${MKK_BACKUP_STORAGE}/"
			fi
		done
	fi
}

install_persistent_rp()
{
	RP_PERSISTENT_STORAGE="/var/local/rp"
	RP_BACKUP_STORAGE="/mnt/us/rp"
	logmsg "I" "install" "" "Setting up RP persistent copy"
	if [ "$(df -k /var/local | awk '$3 ~ /[0-9]+/ { print $4 }')" -lt "512" ] ; then
		# Hu ho... Keep track of this...
		VARLOCAL_OOS="true"
		logmsg "W" "install" "" "Failed to setup RP persistent copy: not enough space left on device"
	else
		mkdir -p "${RP_PERSISTENT_STORAGE}"
		for my_job in debrick cowardsdebrick ; do
			if [ -f "/etc/upstart/${my_job}.conf" ] ; then
				cp -af "/etc/upstart/${my_job}.conf" "${RP_PERSISTENT_STORAGE}/${my_job}.conf"
			fi
			if [ -f "/etc/upstart/${my_job}" ] ; then
				cp -af "/etc/upstart/${my_job}" "${RP_PERSISTENT_STORAGE}/${my_job}"
			fi
		done

		rm -rf "${RP_BACKUP_STORAGE}"
		mkdir -p "${RP_BACKUP_STORAGE}"
		for my_file in ${RP_PERSISTENT_STORAGE}/* ; do
			if [ -f ${my_file} -a ! -L ${my_file} ] ; then
				cp -f "${my_file}" "${RP_BACKUP_STORAGE}/"
			fi
		done
	fi
}

clean_up()
{
	# Cleanup behind us...
	rm -f "/mnt/us/bridge.sh" "/mnt/us/developer.keystore" "/mnt/us/json_simple-1.1.jar" "/mnt/us/gandalf" "/mnt/us/bridge.conf" /mnt/us/*.bin "/mnt/us/jb.sh"
}


## And... Go!
check_model
check_version
mount_root_rw
install_update_key
install_fw54_exec_userstore_flag
install_bridge
install_persistent_mkk
install_persistent_rp
mount_ro
print_jb_install_feedback
clean_up

return 0
