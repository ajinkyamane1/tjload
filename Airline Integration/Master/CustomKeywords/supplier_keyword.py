# MyRandomLibrary.py
import keyword
import random
import string



def generate_random_name(length=8):
    return ''.join(random.choices(string.ascii_uppercase, k=length))


def generate_random_url():
    protocol = random.choice(['http', 'https'])
    domain = ''.join(random.choices(string.ascii_lowercase, k=10))
    extension = random.choice(['com', 'net', 'org'])
    return f"{protocol}://{domain}.{extension}"


def generate_random_username(length=8):
    return ''.join(random.choices(string.ascii_uppercase, k=length))


def generate_random_password(length=10):
    characters = string.ascii_uppercase + string.ascii_lowercase + string.digits
    return ''.join(random.choices(characters, k=length))


def generate_random_domain(length=10):
    return ''.join(random.choices(string.ascii_uppercase, k=length))


def generate_random_organization_code(length=4):
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=length))


def generate_random_accounting_code(length=5):
    return ''.join(random.choices(string.ascii_uppercase, k=length))
