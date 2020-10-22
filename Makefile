.ONESHELL:

.PHONY: deploy
deploy:
	npm run build
	scp -r dist iperyt:/tmp
	cat <<'EOF' | ssh iperyt
	sudo cp -r /tmp/dist/* /var/www/fucklife.ch/alcoholism
	sudo chown -R www:www /var/www/fucklife.ch/alcoholism
	sudo find /var/www/fucklife.ch/alcoholism -type d -exec chmod 0750 {} \;
	sudo find /var/www/fucklife.ch/alcoholism -type f -exec chmod 0640 {} \;
	sudo rm -rf /tmp/dist
	EOF
