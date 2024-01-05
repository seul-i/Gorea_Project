package com.gorea.repository_contents;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Service
public class Geocoding {
	private static final String GEOCODING_API_URL = "https://maps.googleapis.com/maps/api/geocode/json";
	
	@Value("${geocoding.api.key}")
    private String apiKey;

    public Map<String, Double> getLatLongByAddress(String address) {
        try {
            String encodedAddress = URLEncoder.encode(address, "UTF-8");
            String apiUrl = String.format("%s?address=%s&key=%s", GEOCODING_API_URL, encodedAddress, apiKey);

            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            InputStream is = connection.getInputStream();
            BufferedReader streamReader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder responseStrBuilder = new StringBuilder();
            String inputStr;

            while ((inputStr = streamReader.readLine()) != null) {
                responseStrBuilder.append(inputStr);
            }

            Map<String, Double> coordinates = parseGeocodingResponse(responseStrBuilder.toString());
            
            return coordinates;
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    private Map<String, Double> parseGeocodingResponse(String jsonResponse) {
        try {
            JSONObject jsonObject = new JSONObject(jsonResponse);
            String status = jsonObject.getString("status");

            if ("OK".equals(status)) {
                JSONArray results = jsonObject.getJSONArray("results");
                JSONObject location = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("location");

                double lat = location.getDouble("lat");
                double lng = location.getDouble("lng");

                Map<String, Double> coordinates = new HashMap<>();
                coordinates.put("lat", lat);
                coordinates.put("lng", lng);

                return coordinates;
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return null;
    }
}
