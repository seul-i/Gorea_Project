package com.gorea.serivce_trans_edit;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;

import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;

import org.json.JSONObject;

@Service
public class Gorea_Translate_EditRecom{

	private String lang_code;

	@Value("${spring.papago.clientId2}")
	private String clientId;
	
	@Value("${spring.papago.clientSecret2}")
	private String clientSecret;
    
    public List<Gorea_EditRecommend_BoardTO> translateBoardList(List<Gorea_EditRecommend_BoardTO> boardList, String lang_code) {
    	
        this.lang_code = lang_code;


        for (Gorea_EditRecommend_BoardTO board : boardList) {
        	
            try {

                String jsonData1 = translateText(board.getEditrecoSubject(), clientId, clientSecret);
                JSONObject json1 = new JSONObject(jsonData1);
                String titleText = json1.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData2 = translateText(board.getEditrecoSubtitle(), clientId, clientSecret);
                JSONObject json2 = new JSONObject(jsonData2);
                String subText = json2.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                // 번역된 결과를 다시 설정
                board.setEditrecoSubject(titleText);
                board.setEditrecoSubtitle(subText);

                
            } catch (UnsupportedEncodingException e) {
            	
                System.out.println("에러 : " + e.getMessage());
            }
            
        }

        return boardList;
    }
    
    public Gorea_EditRecommend_BoardTO translateBoardView(Gorea_EditRecommend_BoardTO to, String lang_code) {
    	
        this.lang_code = lang_code;
        	
            try {

                String jsonData1 = translateText(to.getEditrecoSubject(), clientId, clientSecret);
                JSONObject json1 = new JSONObject(jsonData1);
                String titleText = json1.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData2 = translateText(to.getEditrecoContent(), clientId, clientSecret);
                JSONObject json2 = new JSONObject(jsonData2);
                String subContent = json2.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                // 번역된 결과를 다시 설정
                to.setEditrecoSubject(titleText);
                to.setEditrecoContent(subContent);

                
            } catch (UnsupportedEncodingException e) {
            	
                System.out.println("에러 : " + e.getMessage());
            }
            

        return to;
    }
    
    public List<Gorea_EditTip_BoardTO> translateTipList(List<Gorea_EditTip_BoardTO> boardList, String lang_code) {
    	
        this.lang_code = lang_code;


        for (Gorea_EditTip_BoardTO board : boardList) {
        	
            try {

                String jsonData1 = translateText(board.getEdittipSubject(), clientId, clientSecret);
                JSONObject json1 = new JSONObject(jsonData1);
                String titleText = json1.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData2 = translateText(board.getEdittipSubtitle(), clientId, clientSecret);
                JSONObject json2 = new JSONObject(jsonData2);
                String subText = json2.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                // 번역된 결과를 다시 설정
                board.setEdittipSubject(titleText);
                board.setEdittipSubtitle(subText);

                
            } catch (UnsupportedEncodingException e) {
            	
                System.out.println("에러 : " + e.getMessage());
            }
            
        }

        return boardList;
    }
    
    public Gorea_EditTip_BoardTO translateTipView(Gorea_EditTip_BoardTO eto, String lang_code) {
    	
        this.lang_code = lang_code;
        	
            try {

                String jsonData1 = translateText(eto.getEdittipSubject(), clientId, clientSecret);
                JSONObject json1 = new JSONObject(jsonData1);
                String titleText = json1.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData2 = translateText(eto.getEdittipContent(), clientId, clientSecret);
                JSONObject json2 = new JSONObject(jsonData2);
                String subContent = json2.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                // 번역된 결과를 다시 설정
                eto.setEdittipSubject(titleText);
                eto.setEdittipContent(subContent);

                
            } catch (UnsupportedEncodingException e) {
            	
                System.out.println("에러 : " + e.getMessage());
            }
            

        return eto;
    }
    
	// 텍스트를 파파고 API를 사용하여 번역하는 메서드
    private String translateText(String text, String clientId, String clientSecret) throws UnsupportedEncodingException {
    	
    	String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
        text = URLEncoder.encode(text, "UTF-8");
        // 언어 번역 코드 
        String param = "source=ko&target="+lang_code+"&text=" + text;
        //String param = "source=ko&target=en&text=" + text;

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
