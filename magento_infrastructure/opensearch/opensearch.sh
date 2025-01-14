echo Install opensearch
echo ...
sleep 5
echo
echo Variables used:
echo OPENSEARCH_VERSION="${OPENSEARCH_VERSION}"
echo OPENSEARCH_ADMIN_USERNAME="${OPENSEARCH_ADMIN_USERNAME}"
echo OPENSEARCH_ADMIN_PASSWORD="${OPENSEARCH_ADMIN_PASSWORD}"
echo
sleep 5

sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y
java -version
sudo apt-get update && sudo apt-get -y install lsb-release ca-certificates curl gnupg2
curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-2.x.list
sudo apt-get update
sudo apt list -a opensearch
sudo apt install opensearch="${OPENSEARCH_VERSION}" -y
sudo env OPENSEARCH_INITIAL_ADMIN_PASSWORD="${OPENSEARCH_ADMIN_PASSWORD}" apt-get install -y opensearch="${OPENSEARCH_VERSION}"
sudo systemctl enable opensearch
sudo systemctl start opensearch
sudo systemctl --no-pager status opensearch
sleep 5
echo Testing opensearch.
curl -X GET https://localhost:9200 -u "${OPENSEARCH_ADMIN_USERNAME}:${OPENSEARCH_ADMIN_PASSWORD}" --insecure
sleep 5
curl -XGET https://localhost:9200/_cluster/health?pretty -u "${OPENSEARCH_ADMIN_USERNAME}:${OPENSEARCH_ADMIN_PASSWORD}" --insecure
sleep 5
sudo sed -i 's/#cluster.name: .*/cluster.name: magento2/' /etc/opensearch/opensearch.yml
sudo sed -i 's/#node.name: .*/node.name: magento2/' /etc/opensearch/opensearch.yml
sudo sed -i 's/#network.host: .*/network.host: 127.0.0.1/' /etc/opensearch/opensearch.yml
sudo sed -i 's/plugins.security.ssl.http.enabled: .*/plugins.security.ssl.http.enabled: false/' /etc/opensearch/opensearch.yml
echo plugins.security.disabled: true >> /etc/opensearch/opensearch.yml  # need to set in magento install command the settings for username
sleep 5
sudo systemctl daemon-reload
sudo systemctl restart opensearch
sudo systemctl --no-pager status opensearch
sleep 5
echo Testing opensearch when ssl is disabled..
sleep 5
curl -XGET http://localhost:9200/_cluster/health?pretty
echo Installation of opensearch successful.
sleep 5