from cryptography.hazmat.primitives.asymmetric.padding import OAEP, MGF1, PKCS1v15
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.serialization import load_pem_public_key
from cryptography.hazmat.backends import default_backend

with open("public.pem", "rb") as pem_file:
    pem_data = pem_file.read()
    # print(pem_data)
    public_key = load_pem_public_key(pem_data, backend=default_backend())
    # print(public_key)
    
with open("encrypted.txt", "rb") as e_file:
    e_data = e_file.read()

# encrypted_data = b'\x01\x23\x45\x67\x89\xab\xcd\xef\x01\x23\x45\x67\x89\xab\xcd\xef'

decrypted_data = public_key.decrypt(
    e_data,
    OAEP(
        mgf=MGF1(algorithm=hashes.base),
        algorithm=hashes.SHA256(),
        label=None
    )
)

print(decrypted_data)