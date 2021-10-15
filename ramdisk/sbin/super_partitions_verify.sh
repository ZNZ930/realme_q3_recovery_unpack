#!/system/bin/sh
#===============================================================================
#
#        AUTHOR: Leon (80119410), yang.li@oppo.com
#
#===============================================================================
result_file=$1
result_flag=$2
touch $result_file
touch $result_flag

echo "fail" > $result_flag
dm_mount=`df | grep dm- | grep /tmp/dm_verify | sort`
check_result="校验结果：\n"
for line in $dm_mount; do
    if [[ $line == /* ]]; then
        if [[ $line == /dev/block/dm-* ]]; then
            sha1=`sha1sum $line | awk '{print $1}'`
            check_result=$check_result$sha1
        else
            check_result=$check_result"    "$line"\n"
        fi
    fi
done
echo $check_result > $result_file
echo "success" > $result_flag
sync
