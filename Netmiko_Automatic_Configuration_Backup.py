#This one works
#Writes the file to the same location as the script, if not defined in script.
#Automatically backsup the current configuration
# For windows make sure to use double \\ when referring to a directory.
from netmiko import ConnectHandler
from datetime import datetime

print('Start of the script ! ! !')
#-------------------------------------------
# Create a dictionary representing the device
BREADCRUMB_Test = { 'host': 'FGTXXXXX',
          'device_type': 'fortinet',
          'ip': '192.168.1.99',
          'username': 'admin', 
          'password': 'admin'} #THIS IS ONLY FOR TESTING. USE CORRECT USERNAME/PASSWORD.

# Establish an SSH connection to the device by passing in the device dictionary
net_connect = ConnectHandler(**BREADCRUMB_Test)
output = net_connect.send_command('show full-configuration')

#Variable for Date
current_date = datetime.today().strftime('(Date_%Y-%m-%d)')
#Variable for Time
now = datetime.now()
current_time = now.strftime("(Time_%H_%M_%S)")

#Creates the file with the format: Hostname_CurrentDate_CurrentTime.cfg
#File is then save to the save directory as the script.
with open(str('C:\\Users\\User01\\Desktop\\FGT_Backups\\' + BREADCRUMB_Test['host']) + '_' + str(current_date) + '_' + str(current_time) + '.cfg', 'w') as f:
          for line in output:
              f.write(line)

#-------------------------------------------          
print('End of the script ! ! !')
