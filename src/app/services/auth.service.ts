import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }
  apiUrl = "url"
  login(username: string, password: string) {
    const body = { username, password }
    return this.http.post(`${this.apiUrl}/login`, body);
  }
}
