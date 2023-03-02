# Putty Usage

## Tunnel

- Tunnel is used to forward local port to a remote machine port

This is used to get around firewall, e.g, local has access to servier1 but has no access to ms sql db on server2. We know server1 can access server2. Using putty tunnel, configure the request to local port 3341 to be forward to server2:3341. So, after connected to server1 using putty, we can access to server2:3341 now.

In this way, it is like accessing server2 from the server1 local.

Putty Configuration ::> Connectioin ::> SSH ::> Tunnels ::> Add new forwarded port

eg., Source, 3341, Destination, 222.333.44.55:3341,

Then click on "Add" button.
