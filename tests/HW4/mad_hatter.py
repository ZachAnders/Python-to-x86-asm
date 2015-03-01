# Mad Hatter

madHatter = 0
rabbit = 1
alice = 2

teaParty = {madHatter:False, rabbit:43, alice: [0,1,2]}
print teaParty

# CHANGE PLACES!
temp = teaParty[madHatter]
teaParty[madHatter] = teaParty[rabbit] if teaParty[madHatter] is False else True
teaParty[rabbit] = teaParty[alice]
teaParty[alice] = temp
print teaParty

# CHANGE PLACES!
temp = teaParty[madHatter]
teaParty[madHatter] = teaParty[rabbit] if teaParty[madHatter] is False else True
teaParty[rabbit] = teaParty[alice]
teaParty[alice] = temp
print teaParty

# CHANGE PLACES!
temp = teaParty[madHatter]
teaParty[madHatter] = teaParty[rabbit] if teaParty[madHatter] is False else True
teaParty[rabbit] = teaParty[alice]
teaParty[alice] = temp
print teaParty[madHatter], teaParty[rabbit], teaParty[alice]

# Expected Output:
# {madHatter: False, alice: [0, 1, 2], rabbit: 43}
# {madHatter: 43, alice: False, rabbit: [0, 1, 2]}
# {madHatter: True, alice: 43, rabbit: False}
# True 43 True

