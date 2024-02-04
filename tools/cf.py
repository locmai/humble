# CloudFlare Python Tools
# pip3 install cloudflare
# TODO update this into tools container/flake.nix
# TODO make it CLI tool with chalk lib and dry-run and shit
# export CLOUDFLARE_EMAIL="locmai0201@gmail.com"
# export CLOUDFLARE_API_TOKEN="verysecretbro"
import CloudFlare

def main():
    cf = CloudFlare.CloudFlare()
    zones = cf.zones.get()

    target_zones = [
        "maibaloc.com"
    ]

    target_contents = [
        'prod-humble-tunnel.maibaloc.com',
        'heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress',
        '192.168.1.225',
    ]

    for zone in zones:
        if zone['name'] in target_zones:
            dns_records = cf.zones.dns_records.get(zone['id'])

            target_dns_records = [record for record in dns_records if any(content for content in target_contents if content in record['content'] )]
            for dns_record in target_dns_records:
                r = cf.zones.dns_records.delete(zone['id'], dns_record['id'])
                print(f"Deleted {dns_record['id']} {dns_record['type']} {dns_record['name']} {dns_record['content']}")


if __name__ == '__main__':
    main()
