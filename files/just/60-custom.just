setup-writer-toolbox:
	flatpak install -y --system flathub org.libreoffice.LibreOffice
	flatpak install -y --system flathub org.zotero.Zotero

	extension_source="/var/lib/flatpak/app/org.zotero.Zotero/current/active/files/share/zotero/integration/libreoffice/Zotero_LibreOffice_Integration.oxt"

	# Install Zotero extension into LibreOffice
	# NOTE: Could be installed using --shared for unopkg, if it is needed for all users
	if ! flatpak run org.libreoffice.LibreOffice unopkg --headless list | grep -q Zotero; then
		flatpak run org.libreoffice.LibreOffice unopkg --headless add "$extension_source"
		echo "Zotero extension installed into LibreOffice"
	else
		echo "Zotero extension already installed"
	fi

remove-writer-toolbox:
	flatpak remove org.libreoffice.LibreOffice
	flatpak remove org.zotero.Zotero

	# Remove Zotero extension from LibreOffice
	if flatpak run org.libreoffice.LibreOffice unopkg --headless list | grep -q Zotero; then
		flatpak run org.libreoffice.LibreOffice unopkg --headless remove Zotero
		echo "Zotero extension removed from LibreOffice"
	else
		echo "Zotero extension was not installed"
	fi
