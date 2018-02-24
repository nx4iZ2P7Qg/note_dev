import java.io.CharArrayWriter;
import java.io.IOException;

/**
 * 以前发送邮件只支持可见字符的传送。
 * 需要有一个方法将不可见的字符转换为可见的字符，产生了Base64编码算法(64个字符，大小写英文52个，数字10个，+，/)
 *
 * 1.将所有字符转换成二进制编码
 * 2.三个8位二进制，分割为四个6位二进制，不足6位的补0，0位的用=代替(都是24位)
 * 3.四个6位二进制前面加00补到8位
 * 4.四个8位转换成10进制查表，[A-Z]对应0-25，[a-z]对应26-51，[0-9]对应52-61，+62，/63
 *
 */
public class Base64 {
    static final char[] alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".toCharArray();

    public Base64() {
    }

    public static char[] encode(byte[] content) {
        CharArrayWriter cw = new CharArrayWriter(4 * content.length / 3);
        int idx = 0;
        int x = 0;

        for (int i = 0; i < content.length; ++i) {
            if (idx == 0) {
                x = (content[i] & 255) << 16;
            } else if (idx == 1) {
                x |= (content[i] & 255) << 8;
            } else {
                x |= content[i] & 255;
            }

            ++idx;
            if (idx == 3) {
                cw.write(alphabet[x >> 18]);
                cw.write(alphabet[x >> 12 & 63]);
                cw.write(alphabet[x >> 6 & 63]);
                cw.write(alphabet[x & 63]);
                idx = 0;
            }
        }

        if (idx == 1) {
            cw.write(alphabet[x >> 18]);
            cw.write(alphabet[x >> 12 & 63]);
            cw.write(61);
            cw.write(61);
        }

        if (idx == 2) {
            cw.write(alphabet[x >> 18]);
            cw.write(alphabet[x >> 12 & 63]);
            cw.write(alphabet[x >> 6 & 63]);
            cw.write(61);
        }

        return cw.toCharArray();
    }

    public static byte[] decode(char[] message) throws IOException {
        byte[] buff = new byte[4];
        byte[] dest = new byte[message.length];
        int bpos = 0;
        int destpos = 0;

        for (int res = 0; res < message.length; ++res) {
            char c = message[res];
            if (c != 10 && c != 13 && c != 32 && c != 9) {
                if (c >= 65 && c <= 90) {
                    buff[bpos++] = (byte) (c - 65);
                } else if (c >= 97 && c <= 122) {
                    buff[bpos++] = (byte) (c - 97 + 26);
                } else if (c >= 48 && c <= 57) {
                    buff[bpos++] = (byte) (c - 48 + 52);
                } else if (c == 43) {
                    buff[bpos++] = 62;
                } else if (c == 47) {
                    buff[bpos++] = 63;
                } else {
                    if (c != 61) {
                        throw new IOException("Illegal char in base64 code.");
                    }

                    buff[bpos++] = 64;
                }

                if (bpos == 4) {
                    bpos = 0;
                    if (buff[0] == 64) {
                        break;
                    }

                    if (buff[1] == 64) {
                        throw new IOException("Unexpected \'=\' in base64 code.");
                    }

                    int v;
                    if (buff[2] == 64) {
                        v = (buff[0] & 63) << 6 | buff[1] & 63;
                        dest[destpos++] = (byte) (v >> 4);
                        break;
                    }

                    if (buff[3] == 64) {
                        v = (buff[0] & 63) << 12 | (buff[1] & 63) << 6 | buff[2] & 63;
                        dest[destpos++] = (byte) (v >> 10);
                        dest[destpos++] = (byte) (v >> 2);
                        break;
                    }

                    v = (buff[0] & 63) << 18 | (buff[1] & 63) << 12 | (buff[2] & 63) << 6 | buff[3] & 63;
                    dest[destpos++] = (byte) (v >> 16);
                    dest[destpos++] = (byte) (v >> 8);
                    dest[destpos++] = (byte) v;
                }
            }
        }

        byte[] var8 = new byte[destpos];
        System.arraycopy(dest, 0, var8, 0, destpos);
        return var8;
    }

    public static void main(String[] args) {
        byte[] ch = {};
        try {
            // 一个迅雷地址，thunder://QUFodHRwOi8vYnRmaWxlLnNvZnQ1NTY2LmNvbS95L0R5bmFzdHkuV2FycmlvcnMuOS50b3JyZW50Wlo=
            ch = Base64.decode("QUFodHRwOi8vYnRmaWxlLnNvZnQ1NTY2LmNvbS95L0R5bmFzdHkuV2FycmlvcnMuOS50b3JyZW50Wlo=".toCharArray());
        } catch (Exception e) {
            e.printStackTrace();
        }
        StringBuilder reString = new StringBuilder();
        for (byte b : ch) {
            // 将ascii码值(byte)转成char
            char tmpChar = (char) b;
            // 拼接成串
            reString.append(tmpChar);
        }
        // 去掉开始的AA与结束的ZZ固定串，剩下的就是真实的下载地址
        System.out.println(reString.toString().substring(2, reString.length() - 2));
    }
}
