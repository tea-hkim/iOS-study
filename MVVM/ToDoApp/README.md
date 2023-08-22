<div align="left">
  <img src="https://github.com/tea-hkim/iOS-study/assets/81206228/17fb8999-7f9a-4823-892f-378c123a114f" width="100" >
</div>
<h2 align="left">✅ To Do App</h2>

### Skills & Tech Stack
* UIKit(Code-Based)
* SnapKit
* Combine
<br/>

### Screenshots
| 할 일 목록 화면 | 할 일 입력 화면 | 할 일 입력 |
|:---:|:---:|:---:|
|<img width="220" alt="to do list" src="https://github.com/tea-hkim/iOS-study/assets/81206228/cddc5f26-100c-426f-a87b-f71fa50bd713">|<img width="220" alt="add to do" src="https://github.com/tea-hkim/iOS-study/assets/81206228/c462407d-0cd3-4d22-a64b-674de0390b12">|<img width="220" alt="to do" src="https://github.com/tea-hkim/iOS-study/assets/81206228/1350f738-8324-405e-a3e9-4cfb1aa83626">|
<br/>

### 구현 기능
#### 할 일 목록 화면
- 무한 스크롤 기능 구현
- refreshControl을 활용하여 새로 고침 기능 구현
- 스와이프 액션을 통한 삭제 기능 구현
- UITextField를 커스텀한 SearchBar 구현
- 완료 목록 숨기기 기능 구현
    
#### 할 일 입력 화면
- 할 일 목록 화면 우측 하단의 + 버튼을 탭할 경우 할 일 추가하기 화면으로 전환
- 할 일 목록 화면의 테이블뷰 셀을 탭할 경우 할 일 수정하기 화면으로 전환
<br/>

### 구현 과정에서 겪은 어려움
#### 할 일 체크를 위해 테이블 뷰의 셀을 탭할 경우 여러 개의 셀이 동시에 눌리는 현상
    - 셀 내부에 할 일 체크를 위한 PassthroughSubject의 구독이 테이블 뷰의 스크롤이 내려가면서 셀이 재사용 됨에 따라 구독이 계속 일어나는 것을 확인
    - 셀이 재사용 될 때 구독을 취소할 수 있도록 변경하여 문제 해결





