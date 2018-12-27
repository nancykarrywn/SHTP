package com.utils;

import java.awt.Color;  
import java.awt.Font;  
import java.util.Random;  

public class VerificationCodeUtil {  
	public final Font mFont = new Font("Arial Black", Font.PLAIN, 15); 
	public final int lineWidth = 2; 
	public final int width = 88; 
	public final int height = 25; 
	public final int count = 200;
	
	public Color getRandColor(int fc, int bc) { 
		final Random random = new Random();
		if (fc > 255) {
			fc = 255;
		}
		if (bc > 255) {
			bc = 255;
		}
		final int r = fc + random.nextInt(bc - fc);
		final int g = fc + random.nextInt(bc - fc);
		final int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}
}  
