import 'package:dio/dio.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  test("Places search test", () async {
    SearchBoxAPI search = SearchBoxAPI(
      apiKey: MAPBOX_KEY,
      limit: 6,
    );
    final CancelToken cancelToken = CancelToken();

    final searchPlaceResponseFuture = search.getSuggestions(
      "central",
      cancelToken: cancelToken,
    );

    final searchPlaceResponse = await searchPlaceResponseFuture;

    expect(searchPlaceResponse, isA<ApiResponse<SuggestionResponse>>());

    expect(searchPlaceResponse.failure, isNull);
    expect(searchPlaceResponse.success, isNotNull);
    expect(searchPlaceResponse.success!.suggestions, isNotEmpty);
    expect(searchPlaceResponse.success!.suggestions, hasLength(6));
  });

  test("Retrive Place by mapbox_id test", () async {
    SearchBoxAPI search = SearchBoxAPI(
      apiKey: MAPBOX_KEY,
      limit: 6,
    );

    final getPlaceResponse = await search.getPlace(
      "dXJuOm1ieHJldDo2cERuNGRfQjhEc0tmNmpleFZpaVVLZWY4TkJqaXJ5YnNqUGlxZ05Cc2JFaDZ0VlVYcEdVT2ZzZS10dUk1bW15Tk9MUUdZaVFRczl1cktjcEVXMUt4RXN4OEc5aVV6dURkemd0b25iQnpDeGNIb29jNFZOSWJGN3lOR2RyQi1JMlYxam51b1ZINUFyZGJuVEQ0SEJ6Nzg2THZpcFZZYndTZG5SYzhtUGl0QVBVNm5SRk1EcFlNRGtWYkJieEFEQm9Qb0xwS2NHWTN5czhFTm5HLUdRbTZIYk5CU0ZZdUN1SFlTUzN4UGxETUt0ZkZ6MTZDZTJVdFZCZmNtTkNDNngwVU5JbWZTLUVVRk5lQ2k4QlNFamUwSVd1SHlXa2hacmJqS3RyRmFzNmtqeU45dGRNU1RhVlFGcWRwZ1paa2RwQ3JiN1pOek91ZWw2LUpRdU5qcnVHcXQzb0g2WmpJdVJlVzhXTGxfaFdGX2U5dVl0ME8ycGR3Y3NkLUsza0VoaDI3NjNxYkZMYUhYSjdpWkJJWkJxRzlpOUpBNGhJa01IOFNZSWZRYlF3Z2szcXFKd0NYa3dRX1JiMk45WjhiMERwbEtFTDd3cWFVRFo5VlRhTWZrZVc5VGdFSTU4SmtXVG14N0tKMU1fZUlfLW1zdFJLZGtBcGVNbHYyZ1FBaGpHRHJkYXllYk92dURXLWlTR3ZQOUVSZ0ozWG5ZZE9fSHYzWDJWVWJocUpYV2tkQkJVZW4ycmQ0QnVkNXdpMTJETGgyV2dJamdNTUk2X2k1NXNhQURkNUdtZkprOEE2Z29ZQWpDLXZEbUdSYjZVQ1NvWExlbUxUcUdibEMxb1U0NkRmUE54RktGS2diazA4dDE0dEdwRTRibXFFdXNnWnNEQ1JVdC1XcHRyMjFBc3IyS1BUaVR4TC1Hbm5mMzlEd0pHdmNrR3psWVpCdC1CLTk4ZlY3dlJCYkxrMEw2RmZGbmF4QUloYkQ0MUtuMm56bDJyM1B4RV80d1FwRHJKWU41T0hia3h6YS11SVFtQkZSeGFCYU9KYm9aTjg3Z2JqZFc5T09iVGhDUDVkZFF1VW5tX05TdlJWZWUwV1FYelN5c1NWbThrQU1LQXBzcnhRZHVlcW9LUXhGZHRXMnlqQ25oQl8xUi1iOXFHUlpyQzY1empKdGVhcENzRkRPRERaME9aZkJGSXhJdG5sanVOLXQxMG1zU2JqcThpVkFLUWZ2NU9xYTBEek1DX3ZqVjh1NVRtX0VYMHVud3ZZVGtGRTFOQ29HTnFFdXo0ZnNWc1Y0cGQyNFZFYmJfQ0ZZdTdBUnI2eXl0V1JUemhiY1FBLV9sM2ozSldSREt5VXBhZDJJQWYycnhOaGtSSHJDNjVndTNsVWx6WTRLMzRFMnBYc05sZ1lBZkJ5UkY0Q01NT2RDZnYweW1IOVg2RlBoejlpbVd3ZFRabjdGWEgydWt2U296Y084U282M1BzMjVNZFh0b1hxWlM4N3hSSkMtOVZ2Y2p0cDYxYW4zbHYyRVd2TWw3MTF4Z2x3ZGptTUpTWHdWSUZsU3Vwb0FHZ0o5NVFfNm03S2Y4UnlCYlY5aEFHaDRqdkNHUmViLWNVYjhnb1hmeWFraFFUb1JiTUJkYVFtblU1aHdQOVF4RWpHWGZaR0ZrSkxjbXp3aGItcUMyTW1oSkpCelY3WGlqeVQtSkhfVndDaWZDYzVvdER4VWtYQUZiQXd1Ujd6eWkyWFQxMG1vS0J2V1JhWkxRYnJfUzduZ2x0RVM1SEhjaEM3QW1kSXdMQzVJX2Q5M0FJZGhLQlNhMjdwdzZ0RVY4N21sV2x1WWhRS2xqRkxLODQtMkh5MVBuR01rMVpKUG91M3pidk5qUk5WOXhkVE90RjFIZkhhSDE0V3ZBN3NDM0hFdU13dXF4Rl9DYlZIZkhodEFSVmpCOFVfeFc1a0JGU1Y0angtSlZfOC1TWXRHa2Rfb1kzREhNQzB6QnRqQWh0NlY4NlcwVTBOc3FGcVhQRDdvdU4zSmVLZ3RmNzExaTlXZXpPWXRnMl9YdTdJLXN3M293ZHVJQUx1TEtKekdpQlhDcnhIby1qeEF3NHF6MzRGNHktWVgxOFVvbjh1OVZGRzk3Ri1JdkJlazJnVnJWa2QtWFdDcXVCMFk2c282OUJjSUZCMFJqb1FhSEZKMC1wWF9DRHRTRV9fS3h2UHRpZGhxcUs3S1dVU1hSV3VfV3hYZ3Y2bkkxNnN5TVgwdldLRkZrTnMxdkdFbDVYRXVMdVo3blJjUlRDMHJIcFc2WF9wOGQtT0JuUjlxLUt0VHlsUXl1MWZsaDRyOHhhWHVlYVBINmFDbXMtQlZHYWJyUXZTckJ3VWNvLVNveHFxN2xfblprRExPT2tGRXZ2RTJ1N0NrMk16c2NmX3R6S2l6SDlZN0J0d0lFYUhjMnA5c2FybjJwcDdqczlBU2xDRXhodmgtT3BLLTNjU0hrZ3JDbWw0RVpndXVSeHNmZmRUU0VnMlJPZjMxcC1ESlpTVGFpSURYaC1DeE5CcGFDQWliekgxSEZfX21WR21BSUNHX1N3RjdHelpNcFI4WjNTR0o0cU1saHIzNjd0WmsyaWZQVmhWeGxsZFo2UWhwS1cycU55eUNpMFZZVlFEbnI0RE8ybEpxUXNXU2h5RDZXVWtZRTVFamJibGtQNGRJMFNodm5kTFdoNnp5bEluN0JRR1N6NTNjdVJ4RkRaUGNLS1NNVU1yeDRDVl9IVE5HeDg4MzEzcFpvakZONWs3Wk5pbkNra2Y1Tzh4QmNXektqLUVnV1F4TTFSanM1ak13dGloRWZCYUZqVURjeDg9",
    );

    expect(getPlaceResponse, isA<ApiResponse<RetrieveResonse>>());
    expect(getPlaceResponse.failure, isNull);
    expect(getPlaceResponse.success, isNotNull);
    final getPlace = getPlaceResponse.success!;
    expect(getPlace.features, isNotEmpty);
    expect(getPlace.features, hasLength(6));
  });
}
