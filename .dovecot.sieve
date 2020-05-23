require [ "fileinto", "envelope", "imap4flags", "include", "mailbox" ];

include :global "default";

# Gitlab
if envelope :is "from" "gitlab@git.calesse.fr" {
	addflag "$label5";
	fileinto :create "INBOX/Gitlab";
}
# Puma-Network
elsif envelope :is :domain "from" "puma-network.net" {
	addflag "$label1";
	fileinto :create "INBOX/Puma-Network";
}
# Bugs
elsif header :contains "subject" [ "bug" ] {
	addflag "$label1";
}
else {
	addflag "$label3";
}


