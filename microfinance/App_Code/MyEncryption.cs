using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Xml;
using System.Text;
using System.Security.Cryptography;

/// <summary>
/// Summary description for MyEncryption
/// </summary>
//public class MyEncryption
//{
//    private byte[] key = {};
//    private byte[] IV = {18, 52, 86, 120, 144, 171, 205, 239};
    
//    public MyEncryption()
//    {
//        //
//        // TODO: Add constructor logic here
//        //
//    }



   
//public string Decrypt(string stringToDecrypt, string sEncryptionKey)
//{
//    byte[] inputByteArray;
//    try 
//    {
//        key = System.Text.Encoding.UTF8.GetBytes(Left(sEncryptionKey, 8));
//        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
//        inputByteArray = Convert.FromBase64String(stringToDecrypt);
//        MemoryStream ms = new MemoryStream();
//        CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(key, IV), CryptoStreamMode.Write);
//        cs.Write(inputByteArray, 0, inputByteArray.Length);
//        cs.FlushFinalBlock();
//        System.Text.Encoding encoding = System.Text.Encoding.UTF8;
//        return encoding.GetString(ms.ToArray());
//    } 
//    catch (Exception e) 
//    {
//        return e.Message;
//    }
//}

//public string Encrypt(string stringToEncrypt, string SEncryptionKey)
//{
//    try 
//    {
//        key = System.Text.Encoding.UTF8.GetBytes(Left(SEncryptionKey, 8));
//        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
//        byte[] inputByteArray = Encoding.UTF8.GetBytes(stringToEncrypt);
//        MemoryStream ms = new MemoryStream();
//        CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(key, IV), CryptoStreamMode.Write);
//        cs.Write(inputByteArray, 0, inputByteArray.Length);
//        cs.FlushFinalBlock();
//        return Convert.ToBase64String(ms.ToArray());
//    } 
//    catch (Exception e) 
//    {
//        return e.Message;
//    }
//}



//}

public class MyEncryption
{
    //private byte[] key = {};
    //private byte[] IV = {10, 20, 30, 40, 50, 60, 70, 80}; // it can be any byte value

    public static string Decrypt(string stringToDecrypt,string sEncryptionKey)
    {

        byte[] key = { };
        byte[] IV = { 10, 20, 30, 40, 50, 60, 70, 80 };
        byte[] inputByteArray = new byte[stringToDecrypt.Length];

        try
        {
            key = Encoding.UTF8.GetBytes(sEncryptionKey.Substring(0, 8));
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            inputByteArray = Convert.FromBase64String(stringToDecrypt.Replace(" ", "+"));

            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(key, IV), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            Encoding encoding = Encoding.UTF8;
            return encoding.GetString(ms.ToArray());
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
    }

    public static string Encrypt(string stringToEncrypt,string sEncryptionKey)
    {

        byte[] key = { };
        byte[] IV = { 10, 20, 30, 40, 50, 60, 70, 80 };
        byte[] inputByteArray; //Convert.ToByte(stringToEncrypt.Length)

        try
        {
            key = Encoding.UTF8.GetBytes(sEncryptionKey.Substring(0, 8));
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            inputByteArray = Encoding.UTF8.GetBytes(stringToEncrypt);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(key, IV), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            return Convert.ToBase64String(ms.ToArray());
        }
        catch (System.Exception ex)
        {
            
            throw new Exception("Problem"+ ex.Message.ToString());
        }
    }
} 
