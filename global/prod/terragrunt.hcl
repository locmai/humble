include  {
    path = find_in_parent_folders("global.hcl")
}

terraform {
    source = "..//_modules/external-dns"
}
