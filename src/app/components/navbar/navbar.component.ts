import { Component, OnInit, ViewChild } from '@angular/core';
import {MatSidenav} from '@angular/material/sidenav';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit{
  constructor(){}
  ngOnInit(): void {
    
  }
  @ViewChild('sidenav')
  sidenav!: MatSidenav;
  isExpanded = true;
  showSubmenu: boolean = false;
  isShowing = false;
  showSubSubMemu: boolean = false;

  mouseenter(){
    if (!this.isExpanded){
      this.isShowing = true;
    }
  }

  mouseleave(){
    if (!this.isExpanded){
      this.isShowing = false;
    }
  }

}
