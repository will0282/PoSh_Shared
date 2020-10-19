#This one works
#Enables https & SSH on interface WAN2
from netmiko import ConnectHandler

print('Start of the script ! ! !')
print(' ')
#-------------------------------------------
# Create a dictionary representing the device
BREAD_Test = { 'host': 'FGT60E',
          'device_type': 'fortinet',
          'ip': '192.168.1.99',
          'username': 'admin',
          'password': 'admin'}

# Establish an SSH connection to the device by passing in the device dictionary
net_connect = ConnectHandler(**BREAD_Test)

# Commands to execute in the connected device
config_commands = [ 'config system interface',
                    'edit wan2',
                    'set allowaccess https ssh',
                    'end' ]

# Senc the previous commands to device for execution
output = net_connect.send_config_set(config_commands)

# Outputs to display the result
print(output)
print(' ')
print('End of the script ! ! !')
