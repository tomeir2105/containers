## Create volume name mysql-data
./volumes.sh --create-volume new_vol

## Run mysql container in the background and mount it with storage
./volumes.sh --mount nginx new_vol

## Kill mysql container
./volumes.sh --kill nginx-mounted

## Verify that data still exists
./volumes.sh --verify-volume new_vol

## Run new mysql container background and mount it with the same storage
./volumes.sh --mount mysql new_vol

## Test that data is the same and not corrupted (accessing remote folder should be enough)
./volumes.sh --mounts
./volumes.sh --test-folder mysql /mnt/new_vol

## List volumes
./volumes.sh --list-volumes

