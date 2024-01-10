public class Utils {
    public static Boolean ValidaCNPJ(String cnpj) {
        if (cnpj == null || cnpj.length() != 14) {
            return false;
        }
        
        Integer[] digitos = new Integer[14];
        for (Integer i = 0; i < 14; i++) {
            digitos[i] = Integer.valueOf(cnpj.substring(i, i+1));
        }
        
        Integer digitoVerificador1 = ((digitos[0]*5 + digitos[1]*4 + digitos[2]*3 + digitos[3]*2 + digitos[4]*9 + digitos[5]*8 + digitos[6]*7 + digitos[7]*6 + digitos[8]*5 + digitos[9]*4 + digitos[10]*3 + digitos[11]*2) / 11);
        digitoVerificador1 = digitoVerificador1 < 2 ? 0 : 11 - digitoVerificador1;
        
        Integer digitoVerificador2 = ((digitos[0]*6 + digitos[1]*5 + digitos[2]*4 + digitos[3]*3 + digitos[4]*2 + digitos[5]*9 + digitos[6]*8 + digitos[7]*7 + digitos[8]*6 + digitos[9]*5 + digitos[10]*4 + digitos[11]*3 + digitos[12]*2) / 11);
        digitoVerificador2 = digitoVerificador2 < 2 ? 0 : 11 - digitoVerificador2;
        
        return digitos[12] == digitoVerificador1 && digitos[13] == digitoVerificador2;
    }
    
    public static Boolean ValidaCPF(String cpf) {
        if (cpf == null || cpf.length() != 11) {
            return false;
        }
        
        Integer[] digitos = new Integer[11];
        for (Integer i = 0; i < 11; i++) {
            digitos[i] = Integer.valueOf(cpf.substring(i, i+1));
        }
        
        Integer digitoVerificador1 = (digitos[0]*10 + digitos[1]*9 + digitos[2]*8 + digitos[3]*7 + digitos[4]*6 + digitos[5]*5 + digitos[6]*4 + digitos[7]*3 + digitos[8]*2) / 11;
        digitoVerificador1 = digitoVerificador1 < 2 ? 0 : 11 - digitoVerificador1;
        
        Integer digitoVerificador2 = (digitos[0]*11 + digitos[1]*10 + digitos[2]*9 + digitos[3]*8 + digitos[4]*7 + digitos[5]*6 + digitos[6]*5 + digitos[7]*4 + digitos[8]*3 + digitos[9]*2) / 11;
        digitoVerificador2 = digitoVerificador2 < 2 ? 0 : 11 - digitoVerificador2;
        
        return digitos[9] == digitoVerificador1 && digitos[10] == digitoVerificador2;
    }
}