NOTE FOR CONTRIBUTERS: The IPS grabber used to work but now doesn't
and I need a good way to get the host name so the Remote Shutdown works feel free to change the code as much as you want 
to make it work!

Rohan's Multi-Tool
Rohan's Multi-Tool is a versatile network and system administration utility designed to help with tasks like network scanning, remote shutdown of Windows and Mac devices, and retrieving system information of devices on your network. It offers a range of features for both enthusiasts and administrators to manage and interact with devices on their local network.

Features
List All PCs on the Network: Scans the network for devices and attempts to retrieve both IP addresses and hostnames.

Remote Shutdown (Windows): Allows for remotely shutting down a Windows PC on the network by entering the computer's name or IP address.

Remote Shutdown (Mac): Allows for remotely shutting down a Mac on the network using its IP address and username.

System Information: Retrieves and displays system information for a given computer (Windows or Mac) on the network.

How to Use: Displays detailed instructions for all features.

Known Issues
Network Scanning: The network scanning feature is using basic command-line tools, and sometimes it may not return the correct IP or hostname. In some cases, devices are detected but not properly listed with their IP address.

Remote Shutdown: The remote shutdown feature for Windows PCs works in most cases but requires administrator privileges and proper network configurations. It may fail if the target machine is not properly configured for remote shutdowns (e.g., Windows firewall settings may block the request).

Mac Remote Shutdown: While the Mac shutdown feature works for most setups, it requires SSH access to the target Mac, which might not always be configured correctly on the device.

Nmap Integration: The Nmap-based scanning for network devices may not always display the IP addresses correctly, depending on network configurations, firewall settings, or device access restrictions.

Installation
Clone the repository:

bash
Copy
Edit
git clone https://github.com/yourusername/rohans-multitool.git
cd rohans-multitool
Make sure to have the required tools:

For Windows remote shutdown, ensure that your Windows machines have file sharing and remote shutdown enabled.

For Mac shutdown, make sure SSH is enabled on your Mac and you have the correct username and password.

To use the tool, just run the batch file:

bash
Copy
Edit
run.bat
Usage
After launching the tool, you'll be presented with a menu where you can choose one of the following options:

List all PCs on the network – Scans your local network for all active devices and their details.

Remotely shutdown a Windows PC – Allows you to remotely shut down a Windows machine using its IP or hostname.

Remotely shutdown a Mac – Allows you to remotely shut down a Mac by entering its IP address and username.

Get system info of a network computer – Retrieve system information from a target computer on the network.

How to Use – Displays detailed usage instructions for each feature.

Exit – Exits the tool.

Contributing
If you find any issues or want to add features to the tool, feel free to fork the repository, make changes, and submit a pull request. Contributions are welcome!
