import CryptoJS from 'crypto-js';

//Encrypting text
export const encrypt = (password) => {
  return CryptoJS.AES.encrypt(password, 'secret key').toString();
};

// Decrypting text
export const  decrypt = (passwordSaved, password) => {
  var bytes  = CryptoJS.AES.decrypt(passwordSaved, 'secret key');
  var result =  bytes.toString(CryptoJS.enc.Utf8);
  return password === result;
}
