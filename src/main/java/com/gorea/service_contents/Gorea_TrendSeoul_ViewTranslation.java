package com.gorea.service_contents;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;


import org.json.JSONObject;

@Service
public class Gorea_TrendSeoul_ViewTranslation{

	private String lang_code;
	
	@Value("${spring.papago.clientId}")
	private String clientId;
	@Value("${spring.papago.clientSecret}")
	private String clientSecret;

//    public Gorea_TrendSeoul_Translation() {
//    	
//    	Gorea_PAPAGO_Config papago = new Gorea_PAPAGO_Config();
//    	
//        this.clientId = papago.getPapagoApiKey();
//        this.clientSecret = papago.getPapagoApiSecret();
//        
//        System.out.println(clientId+"/"+clientSecret);
//    }
    
    public Gorea_TrendSeoul_BoardTO translateBoardView(Gorea_TrendSeoul_BoardTO boardView, String lang_code) {
    	
        this.lang_code = lang_code;
        	
            try {

            	String jsonData1 = translateText(boardView.getSeoulTitle(), clientId, clientSecret);
            	JSONObject json1 = new JSONObject(jsonData1);
            	String titleText = json1.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	boardView.setSeoulTitle(titleText);
         
            	
            	String jsonData2 = translateText(boardView.getSeoulLocGu(), clientId, clientSecret);
            	JSONObject json2 = new JSONObject(jsonData2);
            	String locGuText = json2.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	boardView.setSeoulLocGu(locGuText);
            	
            	String jsonData3 = translateText(boardView.getMainCategory(), clientId, clientSecret);
            	JSONObject json3 = new JSONObject(jsonData3);
            	String mainCategoryText = json3.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	boardView.setMainCategory(mainCategoryText);


            	String jsonData4 = translateText(boardView.getSubCategory(), clientId, clientSecret);
            	JSONObject json4 = new JSONObject(jsonData4);
            	String subCategoryText = json4.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	boardView.setSubCategory(subCategoryText);


            	if (boardView.getSeoulContent() != null && !boardView.getSeoulContent().isEmpty()) {
            	    String jsonData5 = translateText(boardView.getSeoulContent(), clientId, clientSecret);
            	    JSONObject json5 = new JSONObject(jsonData5);
            	    String contentText = json5.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	    boardView.setSeoulContent(contentText);
            	    

            	}

            	if (boardView.getSeoulLoc() != null && !boardView.getSeoulLoc().isEmpty()) {
            	    String jsonData6 = translateText(boardView.getSeoulLoc(), clientId, clientSecret);
            	    JSONObject json6 = new JSONObject(jsonData6);
            	    String locText = json6.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	    boardView.setSeoulLoc(locText);
            	    

            	}

            	if (boardView.getSeoulusageTime() != null && !boardView.getSeoulusageTime().isEmpty()) {
            	    String jsonData7 = translateText(boardView.getSeoulusageTime(), clientId, clientSecret);
            	    JSONObject json7 = new JSONObject(jsonData7);
            	    String usageTimeText = json7.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	    boardView.setSeoulusageTime(usageTimeText);

            	}

            	if (boardView.getSeoulusageFee() != null && !boardView.getSeoulusageFee().isEmpty()) {
            	    String jsonData8 = translateText(boardView.getSeoulusageFee(), clientId, clientSecret);
            	    JSONObject json8 = new JSONObject(jsonData8);
            	    String usageFeeText = json8.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	    boardView.setSeoulusageFee(usageFeeText);

            	}

            	if (boardView.getSeoulTrafficinfo() != null && !boardView.getSeoulTrafficinfo().isEmpty()) {
            	    String jsonData9 = translateText(boardView.getSeoulTrafficinfo(), clientId, clientSecret);
            	    JSONObject json9 = new JSONObject(jsonData9);
            	    String trafficText = json9.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	    boardView.setSeoulTrafficinfo(trafficText);

            	}

            	if (boardView.getSeoulNotice() != null && !boardView.getSeoulNotice().isEmpty()) {
            	    String jsonData10 = translateText(boardView.getSeoulNotice(), clientId, clientSecret);
            	    JSONObject json10 = new JSONObject(jsonData10);
            	    String noticeText = json10.getJSONObject("message").getJSONObject("result").getString("translatedText");
            	    boardView.setSeoulNotice(noticeText);

            	}
                
            } catch (UnsupportedEncodingException e) {
            	
                System.out.println("에러 : " + e.getMessage());
            }
        
        System.out.println(boardView);

        return boardView;
    }
    
	// 텍스트를 파파고 API를 사용하여 번역하는 메서드
    private String translateText(String text, String clientId, String clientSecret) throws UnsupportedEncodingException {
    	
    	String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
        text = URLEncoder.encode(text, "UTF-8");
        // 언어 번역 코드 
        String param = "source=ko&target="+lang_code+"&text=" + text;

        try {
            URL url = new URL(apiURL);
            HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setUseCaches(false);
            con.setDefaultUseCaches(false);

            OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream());
            osw.write(param);
            osw.flush();

            int responseCode = con.getResponseCode();
            // 여기서 필요한 로직 추가...

            if (responseCode == 200) {
                // 성공적인 응답을 받았을 때만 API 응답 내용을 확인
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                StringBuilder result = new StringBuilder();
                String line;

                while ((line = br.readLine()) != null) {
                    result.append(line).append("\n");
                }

                br.close();
                // 여기서 result를 반환하거나 다른 로직을 추가하여 처리
                return result.toString();
                
            } else {
                // 200코드가 아닌 경우 오류 메시지 출력
                return "Error Message: " + con.getResponseMessage() + "\n";
            }
        } catch (IOException e) {
            // IOException 처리
            return "IOException: " + e.getMessage();
        }
    }

}
