# Summary Practice
## Let’s create a Docker volume and mount it to persist MySQL data:
- Create volume name mysql-data
- Run mysql container in the background and mount it with storage
- Kill mysql container
- Verify that data still exists
- Run new mysql container background and mount it with the same storage
- Test that data is the same and not corrupted (accessing remote folder should be enough)
