import { TestBed } from '@angular/core/testing';

import { SerachengineService } from './serachengine.service';

describe('SerachengineService', () => {
  let service: SerachengineService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SerachengineService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
